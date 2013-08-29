require 'nokogiri'
require_relative 'download.rb'
require 'erb'
require 'active_support/core_ext'

doc = Nokogiri::XML(open(FHIR_FILE).read)
doc.remove_namespaces!

def value_by_path(node, path, attr = :value)
  (node.xpath("./#{path}").first || {})[attr]
end

lib_dir  = File.dirname('../lib/fhir/models')
FileUtils.rm_rf(lib_dir)
FileUtils.mkdir_p(lib_dir)


def process_elements(els, prev_path, acc)
  unless el = els.shift
    puts close_class([], prev_path)
    return
  end

  path = el_path(el)

  if is_opening(path, prev_path)
    puts open_class(path)
    puts attr_to_ruby(el)
  elsif is_attr(path, prev_path)
    puts attr_to_ruby(el)
  elsif is_closing(path, prev_path)
    puts close_class(path, prev_path)
  end
  process_elements(els, path, acc)
end

def indent(mes, depth)
  "#{'  '*(depth -1)}#{mes}"
end

def open_class(path)
  indent "class #{ class_name(path)}", path.size
end

def class_name(path)
  path.map{|i| i[0].upcase + i[1..-1]}.join('')
end

def close_class(path, prev_path)
  (path.size..(prev_path.size - 1)).to_a
  .reverse
  .map do |dd|
    indent("end\n", dd + 1)
  end.join
end

def attr_to_ruby(el)
  type = value_by_path(el, 'definition/type/code')
  path = el_path(el)
  indent "attribute :#{attr_name(path)}, #{type}", path.size + 1
end

def attr_name(path)
  path.last
end

def is_attr(path, prev_path)
  path[0..-2] == prev_path[0..-2]
end

def is_opening(path, prev_path)
  path.size > prev_path.size
end

def is_closing(path, prev_path)
  path.size < prev_path.size
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

process_elements initial_elements(doc), [], []
