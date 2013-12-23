require_relative "common"

FHIR_DIR = File.dirname(__FILE__) + "/.."

def load_profile(path) #profile doc
  doc = Nokogiri::XML(open(path).read)
  doc.remove_namespaces!
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
  "  attribute :#{attr_name}, #{type}"
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

extend FhirElementsToTree
extend FhirProfile
extend RubyCodeGeneration

HANDMADE_TYPES = ["ResourceReference"]

def generate_types
  lib_dir  = File.expand_path('lib/fhir/types', FHIR_DIR)
  FileUtils.rm_rf(lib_dir)
  FileUtils.mkdir_p(lib_dir)

  autoloads = []

  profiles(FHIR_DIR).each do |profile_path|
    doc = load_profile(profile_path)
    structures(doc).each do |st|
      type = st_type(st)
      next if HANDMADE_TYPES.include?(type)
      elements = st_elements(st)
      file_name = type.underscore

      tree = make_tree(elements)
      code = tree_to_ruby_code(tree, "Fhir::DataType")
      code += "Fhir.load_extension('#{file_name}')\n"

      autoloads << [type, file_name]

      File.open("#{lib_dir}/#{file_name}.rb", 'w') do |f|
        f << code
      end
    end
  end

  open("#{lib_dir}/autoloads.rb", 'w') do |f|
    f<< ruby_block("module Fhir") do
      autoloads.sort.map do |(c,f)|
        %Q[ autoload :#{c}, 'fhir/types/#{f}.rb']
      end.join("\n")
    end
  end
end
