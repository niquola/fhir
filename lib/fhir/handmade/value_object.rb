class Fhir::ValueObject
  include Virtus::ValueObject
  extend Fhir::ResourceRefering
  include Fhir::Virtus::Serializable
end
