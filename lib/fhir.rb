require 'virtus'

module Fhir
  autoload :VERSION, 'fhir/version'

  autoload :Type, 'fhir/handmade/type'
  autoload :Code, 'fhir/handmade/code'
  autoload :URI, 'fhir/handmade/uri'
  autoload :ResourceReference, 'fhir/handmade/resource_reference'
  autoload :Resource, 'fhir/handmade/resource'
  autoload :ValueObject, 'fhir/handmade/value_object'
  autoload :Money, 'fhir/handmade/money'
  autoload :ResourceRefering, 'fhir/handmade/resource_refering'

  module Virtus
    autoload :ResourceCoercion, 'fhir/virtus/resource_coercion'
    autoload :ResourceAttribute, 'fhir/virtus/resource_attribute'
    autoload :ResourceCollectionAttribute, 'fhir/virtus/resource_collection_attribute'
  end
end

require "fhir/models/autoloads"
require "fhir/types/autoloads"
