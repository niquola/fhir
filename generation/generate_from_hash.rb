require 'nokogiri'
require_relative 'download.rb'
require 'active_support/core_ext'

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

def value_by_path(node, path, attr = :value)
  (node.xpath("./#{path}").first || {})[attr]
end

def el_path(el)
  value_by_path(el, 'path').split('.')
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
  node_name.underscore
end

TYPES_MAPPING = {
  'DateTime' => DateTime,
  'String' => 'String'
}

def attribute_type(node)
  original_type = value_by_path(node[:el], 'definition/type/code')
  TYPES_MAPPING[original_type] || original_type
end

def attribute_minmax(node)
  min = value_by_path(node[:el], 'definition/min')
  max = value_by_path(node[:el], 'definition/max')

  if min.present? && max.present?
    "#{min}..#{max}"
  else
    nil
  end
end

def class_name(node_name)
  node_name.camelize
end

def node_comment(node)
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

def tree_to_ruby_code(tree)
  code = ""

  get_attributes(tree).each do |node_name, node|
    depth = node_depth(node)

    write_attribute = -> {
      minmax = attribute_minmax(node)
      line(code, depth, node_comment(node))

      if minmax && minmax.first == '1'
        line(code, depth, "# Should be present")
      end

      line(code, depth, "attribute :#{attribute_name(node_name)}, #{attribute_type(node)}")
      blank_line(code)
    }

    if get_attributes(node).blank? # it's attr
      write_attribute.call
    else                           # it's a class!
      value_object = depth == 0 ? false : true
      parent_class = value_object ? "Fhir::ValueObject" : "Fhir::Resource"

      classname = class_name(node_name)
      classname = "Fhir::#{classname}" if !value_object

      line(code, depth, node_comment(node))
      line(code, depth, "class #{classname} < #{parent_class}")

      line(code, 0, tree_to_ruby_code(node))
      line(code, depth, "end")
      blank_line(code)

      write_attribute.call if value_object
    end
  end

  code
end

doc = Nokogiri::XML(open(FHIR_FILE).read)
doc.remove_namespaces!
lib_dir  = File.expand_path('../lib/fhir/models', File.dirname(__FILE__))

FileUtils.rm_rf(lib_dir)
FileUtils.mkdir_p(lib_dir)

autoloads = []

doc.xpath('//Profile/structure')
  .each do |st|
  resource_name =  value_by_path(st, 'type')
  file_name = resource_name.underscore
  elements = st.xpath('./element').to_a
  autoloads << [resource_name, "fhir/models/#{file_name}"]

  tree = make_tree(elements)
  puts tree_to_ruby_code(tree) if resource_name == "AdverseReaction"
end

autoload_code = "module Fhir\n"
autoload_code << autoloads.map do |autoload|
  "  autoload :#{autoload.first}, #{autoload.last.inspect}"
end.join("\n")
autoload_code << "\nend\n"

File.open("#{lib_dir}/autoloads.rb",'w+'){|f| f << autoload_code }
