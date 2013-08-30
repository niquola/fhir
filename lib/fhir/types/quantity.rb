class Fhir::Quantity < Fhir::Type
  attribute :values, Array[Fhir::decimal]
  attribute :comparators, Array[Fhir::Code]
  attribute :units, Array[Fhir::String]
  attribute :systems, Array[Fhir::uri]
  attribute :codes, Array[Fhir::Code]
end
