require 'virtus'

module Fhir
  autoload :VERSION, 'fhir/version'
  autoload :Type, 'fhir/type'

  autoload :Code, 'fhir/basic_types/code'
  autoload :URI, 'fhir/basic_types/uri'
  autoload :ResourceReference, 'fhir/basic_types/resource_reference'
  autoload :Resource, 'fhir/basic_types/resource'
  autoload :ValueObject, 'fhir/basic_types/value_object'
  autoload :Type, 'fhir/basic_types/type'
  autoload :Money, 'fhir/basic_types/money'
end

require "fhir/models/autoloads"
require "fhir/types/autoloads"
