class Fhir::Identifier < Fhir::Type
  attribute :uses, Array[Fhir::Code]
  attribute :labels, Array[Fhir::String]
  attribute :systems, Array[Fhir::uri]
  attribute :keys, Array[Fhir::String]
  attribute :periods, Array[Fhir::Period]
  attribute :assigners, Array[Fhir::Resource(Organization)]
end
