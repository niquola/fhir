require 'nokogiri'
require_relative 'download.rb'
require 'erb'
require 'active_support/core_ext'


def value_by_path(node, path, attr = :value)
  (node.xpath("./#{path}").first || {})[attr]
end


def line(acc, depth, lines)
  lines.split("\n").each do |line|
    acc<< indent(line, depth) << "\n"
  end
end

def blank_line(acc)
  acc<< "\n"
end

def from_to(max, min,&block)
  (min...max).to_a
  .reverse
  .each(&block)
end

def el_comment(el)
  value_by_path(el, 'definition/short')
  .split("\n")
  .map{|l| "# #{l}"}
  .join("\n")
end

def is_root_class(path)
  path.size == 1
end

def process_elements(els)
  a = ""
  el = els.shift
  path = el_path(el)
  d = depth(path)
  next_path = el_path(els.first)

  line a, d, el_comment(el)
  unless is_root_class(path)
    line a, d, add_attr(el)
    blank_line a
  end

  if is_closing(next_path, path)
    from_to(path.size, next_path.size < 1 ? 1 : next_path.size) do |dd|
      line a, dd - 1, close_class(path)
    end
  end

  if is_opening(next_path, path)
    line a, d, open_class(path)
    if is_root_class(path)
      line a, d + 1, "include Virtus"
    else
      line a, d + 1, "include Virtus::ValueObject"
    end
  end

  if els.empty?
    a
  else
    a << process_elements(els)
  end
end

def indent(mes, depth)
  "#{'  '*(depth < 0 ? 0 : depth)}#{mes}"
end

def depth(path)
  path.size - 1
end

def open_class(path)
  "class #{ class_name(path)}"
end

def class_name(path)
  path.last.camelize
end

def close_class(path)
  "end"
end

def add_attr(el)
  path = el_path(el)
  "attribute :#{attr_name(path)}, #{attr_type(el)}"
end

def attr_type(el)
  type = value_by_path(el, 'definition/type/code')
  {
    'dateTime' => DateTime ,
    'string' => 'String'
  }[type] || type || el_path(el).last.camelize
end

def attr_name(path)
  path.last
end

def is_attr(path, prev_path)
  path[0..-2] == prev_path[0..-2]
end

def is_opening(path, prev_path)
  depth(path) > depth(prev_path)
end

def is_closing(path, prev_path)
  depth(path) < depth(prev_path)
end

def el_path(el)
  return [] if el.nil?
  value_by_path(el, 'path').split('.')
end

def initial_elements(doc)
  doc.xpath('//Profile/structure/element')
  .select {|el| el_path(el).first == 'Conformance' }
  .to_a
end

# MAIN

doc = Nokogiri::XML(open(FHIR_FILE).read)
doc.remove_namespaces!
lib_dir  = File.expand_path('../lib/fhir/models', __dir__)

FileUtils.rm_rf(lib_dir)
FileUtils.mkdir_p(lib_dir)

doc.xpath('//Profile/structure')
.each do |st|
  resource_name =  value_by_path(st, 'type')
  file_name = resource_name.underscore
  elements = st.xpath('./element').to_a
  code = process_elements(elements)
  File.open("#{lib_dir}/#{file_name}.rb",'w+'){|f| f<< code }
end
