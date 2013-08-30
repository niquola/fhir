class Fhir::ResourceReference < Fhir::Type
  attribute :types, Array[Fhir::Code]
  attribute :references, Array[Fhir::String]
  attribute :displays, Array[Fhir::String]
end
