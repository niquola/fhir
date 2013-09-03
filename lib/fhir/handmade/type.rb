class Fhir::Type
  include Virtus::ValueObject
  extend Fhir::ResourceRefering
  include Fhir::Virtus::Serializable
end
