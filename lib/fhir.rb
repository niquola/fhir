require 'virtus'

require 'active_support'
require 'fhir/config'

module Fhir
  autoload :VERSION,           'fhir/version'

  autoload :Type,              'fhir/handmade/type'
  autoload :DataType,          'fhir/handmade/data_type'
  autoload :ValueObject,       'fhir/handmade/value_object'

  autoload :Collection,        'fhir/handmade/collection'
  autoload :Code,              'fhir/handmade/code'
  autoload :CodeSystem,        'fhir/handmade/code_system'
  autoload :URI,               'fhir/handmade/uri'
  autoload :ResourceReference, 'fhir/handmade/resource_reference'
  autoload :Resource,          'fhir/handmade/resource'
  autoload :Money,             'fhir/handmade/money'
  autoload :Binary,            'fhir/handmade/binary'

  autoload :Virtus,            'fhir/virtus'
end

require "fhir/models/autoloads"
require "fhir/types/autoloads"

def Fhir.load_extension(file_name)
  fhir_extension_dir = File.dirname(__FILE__) + "/fhir/extensions"
  extension_paths = [fhir_extension_dir, Fhir.config[:extension_path]].compact

  extension_paths.each do |path|
    fname = path + "/#{file_name}.rb"

    load(fname) if File.exist?(fname)
  end
end
