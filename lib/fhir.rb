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
  autoload :Coding,            'fhir/handmade/coding'
  autoload :CodeableConcept,   'fhir/handmade/codeable_concept'

  autoload :Virtus,            'fhir/virtus'
end

require "fhir/models/autoloads"
require "fhir/types/autoloads"

def Fhir.load_extension(file_name)
  if extension_path = Fhir.config[:extension_path]
    fname = extension_path + "/#{file_name}.rb"
    if File.exists?(fname)
      load(fname)
    end
  end
end
