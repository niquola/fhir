require 'virtus'

require 'active_support'

module Fhir
  autoload :VERSION,           'fhir/version'

  autoload :Type,              'fhir/handmade/type'
  autoload :DataType,          'fhir/handmade/data_type'
  autoload :ValueObject,       'fhir/handmade/value_object'

  autoload :Collection,        'fhir/handmade/collection'
  autoload :Code,              'fhir/handmade/code'
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

def Fhir.load_handmade(file_name)
  fname = File.dirname(__FILE__) + "/fhir/handmade/#{file_name}.rb"
  if File.exists?(fname)
    load(fname)
  end
end
