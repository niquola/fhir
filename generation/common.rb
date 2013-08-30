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

  def st_type(st)
    value_by_path(st, './type')
  end

  def el_type(el)
    value_by_path(el, 'definition/type/code')
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

  def attribute_type(node, minmax)
    original_type = el_type(node[:el])
    mapped_type = nil

    if original_type
      mapped_type = TYPE_MAPPINGS[original_type]
      if mapped_type.nil?
        if original_type.starts_with?("@")
          mapped_type = original_type.gsub('@', '').split('.').map(&:camelize).join("::")
          mapped_type = "Fhir::#{mapped_type}"
        else
          mapped_type = "Fhir::#{original_type}"
        end
      end
    else
      mapped_type = attribute_class_name(node_path(node).last)
    end

    if mapped_type =~ /^Fhir::Resource\([^\)]+\)$/
      mapped_type.gsub!(/(Resource)(\(.*?\))?/) do |*args|
        types = $2.to_s.gsub(/[()]/, '').split('|')
        types -= MISSED_RESOURCES
        types = types.map { |t| "Fhir::#{t}" }.join(", ")

        "ResourceReference#{types.present? ? '[' + types + ']' : ''}"
      end
    end

    apply_minmax_to_type(mapped_type, minmax) + " # #{original_type}"
  end

  def apply_minmax_to_type(type, minmax)
    minmax && minmax.last == '*' ? "Array[#{type}]" : type
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

  def attribute_name(node_name)
    node_name.gsub('[x]', '').underscore
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

  def tree_to_ruby_code(tree, root_class_name)
    code = ""

    get_attributes(tree).each do |node_name, node|
      depth = node_depth(node)

      write_attribute = ->(write_comment = true) {
        minmax = el_minmax(node[:el])
        ruby_type = attribute_type(node, minmax)

        line(code, depth, attribute_comment(node)) if write_comment

        if minmax && minmax.first == '1'
          line(code, depth, "# Should be present")
        end

        line(code, depth, "attribute :#{attribute_name(node_name)}, #{ruby_type}")
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
