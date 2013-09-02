require 'virtus'

module Fhir
  autoload :VERSION, 'fhir/version'

  autoload :Type, 'fhir/basic_types/type'
  autoload :Code, 'fhir/basic_types/code'
  autoload :URI, 'fhir/basic_types/uri'
  autoload :ResourceReference, 'fhir/basic_types/resource_reference'
  autoload :Resource, 'fhir/basic_types/resource'
  autoload :ValueObject, 'fhir/basic_types/value_object'
  autoload :Money, 'fhir/basic_types/money'

  module Virtus
    autoload :ResourceCoercion, 'fhir/virtus/resource_coercion'
    autoload :ResourceAttribute, 'fhir/virtus/resource_attribute'
    autoload :ResourceCollectionAttribute, 'fhir/virtus/resource_collection_attribute'
  end
end

require "fhir/models/autoloads"
require "fhir/types/autoloads"
