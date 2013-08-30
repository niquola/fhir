class Fhir::Quantity < Fhir::Type
  attribute :values, Array[Float]
  attribute :comparators, Array[Fhir::Code]
  attribute :units, Array[String]
  attribute :systems, Array[Fhir::uri]
  attribute :codes, Array[Fhir::Code]
end
