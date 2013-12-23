require 'nokogiri'
require 'active_support/core_ext'
require 'fileutils'

IGNORED_ATTRIBUTES = %w[contained extension]

module FhirElementsToTree
  def add_node(tree, el)
    path = el_path(el)
    parent_node = tree

    path[0..-2].each do |path_el|
      # current_node = current_node[path_el][:attributes] rescue { path_el => make_node }
      parent_node = get_attribute(parent_node, path_el)
    end

    add_attribute(parent_node, path.last, make_node(el))
  end

  def get_attribute(node, name)
    get_attributes(node)[name]
  end

  def get_attributes(node)
    node[:attributes]
  end

  def add_attribute(node, name, value)
    node[:attributes][name] = value
  end

  def make_node(el)
    { attributes: {}, el: el }
  end

  def node_path(node)
    el_path(node[:el])
  end

  def node_depth(node)
    node_path(node).size - 1
  end

  def make_tree(els)
    els.each_with_object(make_node(nil)) do |el, tree|
      add_node(tree, el) unless IGNORED_ATTRIBUTES.include?(el_name(el))
    end
  end
end

module FhirProfile
  def structures(doc) #structures
    doc.xpath('//Profile/structure')
  end

  def st_elements(st)
    st.xpath('./element').to_a
  end

  def el_path(el)
    return [] if el.nil?
    value_by_path(el, 'path').split('.')
  end

  def value_by_path(node, path, attr = :value)
    (node.xpath("./#{path}").first || {})[attr]
  end

  def values_by_path(node, path, attr = :value)
    node.xpath("./#{path}").map do |n|
      n[attr]
    end
  end

  def st_type(st)
    value_by_path(st, './type')
  end

  def el_types(el)
    values_by_path(el, 'definition/type/code')
  end

  def el_name_reference(el)
    value_by_path(el, 'definition/nameReference')
  end

  def el_name(el)
    el_path(el).last
  end

  def el_min(el)
    value_by_path(el, 'definition/min')
  end

  def el_max(el)
    value_by_path(el, 'definition/max')
  end

  def el_minmax(el)
    min = el_min(el)
    max = el_max(el)

    min && max ? [min, max] : nil
  end

  def el_multiple?(el)
    el_max(el) != '1'
  end
end

module RubyCodeGeneration
  TYPE_MAPPINGS = {
    'string' => 'String',
    'code' => 'Fhir::Code',
    'integer' => 'Integer',
    'boolean' => 'Boolean',
    'decimal' => 'Float',
    'dateTime' => 'DateTime',
    'uri' => 'Fhir::URI',
    'xhtml' => 'String',
    'idref' => 'Integer',
    'base64Binary' => 'String',
    'date' => 'Date',
    '*' => "Object", # hack
    'oid' => 'String',
    'instant' => 'DateTime',
    'Duration' => "Time",
    'id' => "String",
    'Age' => "Fhir::Quantity",
    'Distance' => "Fhir::Quantity",
    'Duration' => "Fhir::Quantity",
    'Count' => "Fhir::Quantity"
  }

  MISSED_RESOURCES = [
    'Appointment',
    "InterestOfCare",
    "Any"
  ]

  RENAMINGS = {
    ["MedicationAdministration", "dosage", "method"] => "method_name",
    ["MedicationDispense", "dispense", "dosage", "method"] => "method_name",
    ["MedicationPrescription", "dosageInstruction", "method"] => "method_name",
    ["MedicationStatement", "dosage", "method"] => "method_name",
    ["Observation", "method"] => "method_name",
    ["Specimen", "collection", "method"] => "method_name"
  }

  def attribute_resource_types(node)
    types = el_types(node[:el])
    puts "WARNING: too many types for resource ref #{el_path(node[:el])} #{types.inspect}" if types.length > 1

    original_type = types.find {|t| t.include?("Resource(") }
    types = original_type.gsub!(/^Resource\((.*?)?\)/, '\\1').split('|').map do |type|
      MISSED_RESOURCES.include?(type) ? nil : "Fhir::#{type}"
    end.compact

    types.empty? ? ["Fhir::Resource"] : types
  end

  def attribute_resource_ref?(node)
    el_types(node[:el]).any? do |original_type|
      !! original_type.to_s.match(/^Resource\(/)
    end
  end

  def attribute_types(node)
    original_types = el_types(node[:el])
    name_reference = el_name_reference(node[:el])

    if original_types.present?
      original_types.map do |original_type|
        mapped_type = TYPE_MAPPINGS[original_type]

        if mapped_type.nil?
          if original_type.starts_with?("@")
            mapped_type = original_type.gsub('@', '').split('.').map(&:camelize).join("::")
            mapped_type = "Fhir::#{mapped_type}"
          else
            mapped_type = "Fhir::#{original_type}"
          end
        else
          mapped_type
        end
      end.compact
    elsif name_reference.present?
      full_class_name = (["Fhir"] + name_reference.split('.')).map(&:camelize).join("::")
      [full_class_name]
    else
      [attribute_class_name(node_path(node).last)]
    end
  end

  def indent(depth, mesg)
    "#{'  '*(depth < 0 ? 0 : depth)}#{mesg}"
  end

  def line(code, depth, lines)
    lines.split("\n").each do |line|
      code << indent(depth, line) << "\n"
    end
  end

  def blank_line(code)
    code << "\n"
  end

  KEYWORDS = ["class"]

  def attribute_name(node)
    node_path = node_path(node)
    class_name = node_path[-2].underscore
    node_name = node_path.last

    attr_name = node_name.gsub('[x]', '').underscore

    if KEYWORDS.include?(attr_name)
      attr_name = "#{class_name}_#{attr_name}"
    end

    if RENAMINGS.keys.include?(node_path)
      attr_name = RENAMINGS[node_path]
    end

    attr_name
  end

  def attribute_class_name(node_name)
    node_name.camelize
  end

  def attribute_comment(node)
    el = node[:el]
    desc_type = node[:attributes].blank? ? "short" : "formal"

    cmt = value_by_path(el, "definition/#{desc_type}").split("\n")
      .map{|l| "# #{l}"}.join("\n")

    wrap_text(cmt, 60).gsub("\n", "\n# ")
  end

  def wrap_text(text, line_length, character = "\n")
    text.split("\n").collect do |line|
      line.length > line_length ? line.gsub(/(.{1,#{line_length}})(\s+|$)/, "\\1\n").strip : line
    end * "\n"
  end

  def reference_name(node)
    attr_name = attribute_name(node)
    "#{attr_name}_ref"
  end

  def attribute_validation(node, attr_name)
    if attribute_types(node) == ["Boolean"]
      "  validates_inclusion_of :#{attr_name}, in: [true, false], message: 'must be either true or false'"
    else
      "  validates_presence_of :#{attr_name}"
    end
  end

  def attribute_invariant_code(node)
    return unless required?(node)
    if attribute_resource_ref?(node)
      attribute_validation(node, reference_name(node))
    else
      attribute_validation(node, attribute_name(node))
    end
  end

  def has_invariants?(node)
    get_attributes(node)
      .values
      .any? { |n| required?(n) }
  end

  def ruby_block_code(start, content)
    [start, content, 'end'].join("\n") << "\n"
  end

  def node_invariants(node)
    code = get_attributes(node).map do |_, n|
      attribute_invariant_code(n)
    end.compact.join("\n")

    ruby_block_code 'invariants do',  code
  end

  def is_collection?(node)
    minmax = el_minmax(node[:el])
    minmax.last == '*'
  end

  def resource_ref_code(node)
    resource_types = attribute_resource_types(node)
    res_ref_method = is_collection?(node) ? 'resource_references' : 'resource_reference'
    "#{res_ref_method} :#{attribute_name(node)}, [#{resource_types.join(", ")}]"
  end

  def required?(node)
    minmax = el_minmax(node[:el])
    minmax.present? && minmax.first == '1'
  end

  def plain_attribute_type(node)
    types = attribute_types(node)

    if types.size > 1
      virtus_type = is_collection?(node) ? 'Collection' : 'Type'
      return "*Fhir::#{virtus_type}[#{types.join(', ')}]"
    end

    ruby_type = types.first

    return ruby_type unless is_collection?(node)
    "Array[#{ruby_type}]"
  end

  def plain_attribute_code(node)
    attr_name = attribute_name(node)
    attr_type = plain_attribute_type(node)
    "attribute :#{attr_name}, #{attr_type}"
  end

  def write_attribute(node)
    if attribute_resource_ref?(node)
      resource_ref_code(node)
    else
      plain_attribute_code(node)
    end
  end

  def classname(node_name, node)
    classname = attribute_class_name(node_name)

    if value_object?(node)
      classname
    else
      "Fhir::#{classname}"
    end
  end

  def value_object?(node)
    node_depth(node) != 0
  end

  def parent_class(node, root_class_name)
    value_object?(node) ? "Fhir::ValueObject" : root_class_name
  end

  def is_attribute?(node)
    get_attributes(node).blank? # it's attr
  end

  def attribute_to_ruby_code(node_name, node, root_class_name)
    code = ""
    depth = node_depth(node)

    if is_attribute?(node)
      line(code, depth, attribute_comment(node))
      line(code, depth, write_attribute(node))
      blank_line(code)
    else                           # it's a class!
      line(code, depth, attribute_comment(node))
      line(code, depth, "class #{classname(node_name, node)} < #{parent_class(node, root_class_name)}")

      if has_invariants?(node)
        line(code, depth + 1, node_invariants(node))
        blank_line(code)
      end

      line(code, 0, tree_to_ruby_code(node, root_class_name))
      line(code, depth, 'end')

      blank_line(code)

      if value_object?(node)
        line(code, depth, write_attribute(node))
        blank_line(code)
      end
      code
    end
  end

  def tree_to_ruby_code(tree, root_class_name)
    get_attributes(tree)
      .map do |node_name, node|
      attribute_to_ruby_code(node_name, node, root_class_name)
    end.join
  end
end
