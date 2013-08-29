require 'nokogiri'
require_relative 'download.rb'
require 'erb'
require 'active_support/core_ext'


def value_by_path(node, path, attr = :value)
  (node.xpath("./#{path}").first || {})[attr]
end


def line(acc, depth, line)
  acc<< indent(line, depth) << "\n"
end

def from_to(max, min,&block)
  (min...max).to_a
  .reverse
  .each(&block)
end

def process_elements(els, prev_path, acc)
  acc.tap do |a|
    el = els.shift
    path = el_path(el)
    d = depth(path)

    if is_closing(path, prev_path)
      from_to(depth(prev_path), d) do |dd|
	line a, dd, close_class(path)
      end
    end

    if is_opening(path, prev_path)
      line a, (d -1), open_class(path)
    end

    line a, d, add_attr(el)

    unless els.empty?
      process_elements(els, path, a)
    else
      from_to(d, 0) do |dd|
	line a, dd, close_class(path)
      end
    end
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
  (path[-2] || path.last).camelize
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
  elements.shift
  code = process_elements(elements, [], "")
  File.open("#{lib_dir}/#{file_name}.rb",'w+'){|f| f<< code }
end
