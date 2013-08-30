class Fhir::Coding < Fhir::Type
  attribute :systems, Array[Fhir::uri]
  attribute :codes, Array[Fhir::Code]
  attribute :displays, Array[Fhir::String]
end
