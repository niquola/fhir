class Fhir::Identifier < Fhir::Type
  attribute :uses, Array[Fhir::Code]
  attribute :labels, Array[String]
  attribute :systems, Array[Fhir::uri]
  attribute :keys, Array[String]
  attribute :periods, Array[Fhir::Period]
  attribute :assigners, Array[Fhir::Resource(Organization)]
end
