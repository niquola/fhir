require_relative "common"

extend FhirElementsToTree
extend FhirProfile
extend RubyCodeGeneration

def generate_resources
  doc = Nokogiri::XML(open(File.dirname(__FILE__) + "/../meta/profiles-resources.xml").read)
  doc.remove_namespaces!
  lib_dir  = File.expand_path('../lib/fhir/models', File.dirname(__FILE__))

  FileUtils.rm_rf(lib_dir)
  FileUtils.mkdir_p(lib_dir)

  autoloads = []

  doc.xpath('//Profile/structure').each do |st|
    resource_name =  value_by_path(st, 'type')
    file_name = resource_name.underscore
    elements = st.xpath('./element').to_a
    autoloads << [resource_name, "fhir/models/#{file_name}"]

    tree = make_tree(elements)
    code = tree_to_ruby_code(tree, "Fhir::Resource")
    code += "\nFhir.load_extension('#{file_name}')\n"
    File.open("#{lib_dir}/#{file_name}.rb",'w+'){ |f| f << code }
  end

  autoload_code = "module Fhir\n"

  autoload_code << autoloads.sort.map do |autoload|
    "  autoload :#{autoload.first}, #{autoload.last.inspect}"
  end.join("\n")

  autoload_code << "\nend\n"

  File.open("#{lib_dir}/autoloads.rb",'w+'){|f| f << autoload_code }
end
