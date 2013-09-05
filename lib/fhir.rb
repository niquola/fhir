require 'virtus'

require 'active_support'

module Fhir
  autoload :VERSION, 'fhir/version'

  autoload :Type, 'fhir/handmade/type'
  autoload :DataType, 'fhir/handmade/data_type'
  autoload :ValueObject, 'fhir/handmade/value_object'

  autoload :Collection, 'fhir/handmade/collection'
  autoload :Code, 'fhir/handmade/code'
  autoload :URI, 'fhir/handmade/uri'
  autoload :ResourceReference, 'fhir/handmade/resource_reference'
  autoload :Resource, 'fhir/handmade/resource'
  autoload :Money, 'fhir/handmade/money'

  autoload :Virtus, 'fhir/virtus'
  autoload :Validations, 'fhir/validations'
end

require "fhir/models/autoloads"
require "fhir/types/autoloads"
