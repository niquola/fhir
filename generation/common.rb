require 'nokogiri'
require 'active_support/core_ext'
require 'fileutils'

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
      add_node(tree, el)
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

  def attribute_resource_types(node)
    types = el_types(node[:el])
    puts "to many types for resource ref #{el_path(node[:el])} #{types.inspect}" if types.length > 1

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

  def attribute_name(node_path, minmax)
    class_name = node_path[-2].underscore
    node_name = node_path[-1]

    attr_name = node_name.gsub('[x]', '').underscore
    attr_name = "#{class_name}_#{attr_name}" if KEYWORDS.include?(attr_name)
    minmax && minmax.last == '*' ? attr_name.pluralize : attr_name
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

  IGNORED_ATTRIBUTES = %w[contained text extension]

  def tree_to_ruby_code(tree, root_class_name)
    code = ""

    get_attributes(tree).each do |node_name, node|
      depth = node_depth(node)
      node_path = node_path(node)
      next if IGNORED_ATTRIBUTES.include?(node_name)

      write_attribute = ->(write_comment = true) {
        minmax = el_minmax(node[:el])
        is_collection = minmax.last == '*'

        line(code, depth, attribute_comment(node)) if write_comment

        if minmax && minmax.first == '1'
          line(code, depth, "# Should be present")
        end

        if attribute_resource_ref?(node)
          resource_types = attribute_resource_types(node)

          res_ref_method = is_collection ? 'resource_references' : 'resource_reference'

          line(code, depth, "#{res_ref_method} :#{attribute_name(node_path, minmax)}, [#{resource_types.join(", ")}]")
        else
          ruby_types = attribute_types(node)
          # fhir_types_present = ruby_types.any? { |rt| rt.include?("Fhir::") }

          if ruby_types.size == 1
            types_code = is_collection ? "Array[#{ruby_types.first}]" : ruby_types.first
          else
            types_code = "*Fhir::#{is_collection ? 'Collection' : 'Type'}[#{ruby_types.join(', ')}]"
          end

          line(code, depth, "attribute :#{attribute_name(node_path, minmax)}, #{types_code}")
        end

        blank_line(code)
      }

      if get_attributes(node).blank? # it's attr
        write_attribute.call
      else                           # it's a class!
        value_object = depth == 0 ? false : true
        parent_class = value_object ? "Fhir::ValueObject" : root_class_name

        classname = attribute_class_name(node_name)
        classname = "Fhir::#{classname}" if !value_object

        line(code, depth, attribute_comment(node))
        line(code, depth, "class #{classname} < #{parent_class}")

        line(code, 0, tree_to_ruby_code(node, root_class_name))
        line(code, depth, "end")
        blank_line(code)

        write_attribute.call(false) if value_object
      end
    end

    code
  end
end
