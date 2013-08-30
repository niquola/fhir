require 'nokogiri'
require 'active_support/core_ext'
FHIR_DIR = "#{File.dirname(__FILE__)}/.."


module FhirProfile
  def load_profile(path) #profile doc
    doc = Nokogiri::XML(open(path).read)
    doc.remove_namespaces!
  end

  def structures(doc) #structures
    doc.xpath('//Profile/structure')
  end

  def elements(st)
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

  def el_multiple?(el)
    el_max(el) != '1'
  end
end

module FhirSimpleTypes
  def t_to_ruby(type)
    {
      'string' => 'String',
      'code' => 'Fhir::Code',
      'integer' => 'Integer',
      'boolean' => 'Boolean',
      'decimal' => 'Float',
      'dateTime' => 'DateTime'
    }[type] || "Fhir::#{type}"
  end
end

def ruby_block(head, &block)
  a = ""
  a<< head << "\n"
  a<< yield << "\n"
  a<< "end" << "\n"
  a
end

def ruby_class_open(el)
  "class Fhir::#{el_name(el).camelize} < Fhir::Type"
end

def attr_to_ruby(el)
  type = t_to_ruby(el_type(el))
  attr_name = el_name(el).underscore
  if el_multiple?(el)
    "  attribute :#{attr_name}, #{type}"
  else
    "  attribute :#{attr_name.pluralize}, Array[#{type}]"
  end
end

def ruby_class_from_st(st)
  els = elements(st)
  ruby_block ruby_class_open(els.first) do
    els[1..-1].map do |el|
      attr_to_ruby(el)
    end
    .join("\n")
  end
end

def profiles(base_path)
  Dir["#{base_path}/meta/type-*profile.xml"]
end

extend FhirProfile
extend FhirSimpleTypes

lib_dir  = File.expand_path('lib/fhir/types', FHIR_DIR)
FileUtils.rm_rf(lib_dir)
FileUtils.mkdir_p(lib_dir)

autoloads = []

profiles(FHIR_DIR).each do |profile_path|
  doc = load_profile(profile_path)
  structures(doc).each do |st|
    type = st_type(st)
    file_name = type.underscore
    autoloads << [type, file_name]

    File.open("#{lib_dir}/#{file_name}.rb", 'w') do |f|
      f<< ruby_class_from_st(st)
    end
  end
end

open("#{lib_dir}/autoloads.rb", 'w') do |f|
  f<< ruby_block("module Fhir") do
    autoloads.map do |(c,f)|
      %Q[ autoload :#{c}, 'fhir/types/#{f}.rb']
    end.join("\n")
  end
end
