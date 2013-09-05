require 'virtus'

require 'active_support'

module Fhir
  autoload :VERSION, 'fhir/version'

  autoload :Type, 'fhir/handmade/type'
  autoload :Collection, 'fhir/handmade/collection'
  autoload :Code, 'fhir/handmade/code'
  autoload :URI, 'fhir/handmade/uri'
  autoload :ResourceReference, 'fhir/handmade/resource_reference'
  autoload :Resource, 'fhir/handmade/resource'
  autoload :ValueObject, 'fhir/handmade/value_object'
  autoload :Money, 'fhir/handmade/money'
  autoload :ResourceRefering, 'fhir/handmade/resource_refering'


  autoload :Virtus, 'fhir/virtus'
  autoload :Validations, 'fhir/validations'
end

require "fhir/models/autoloads"
require "fhir/types/autoloads"
