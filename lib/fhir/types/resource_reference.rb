class Fhir::ResourceReference < Fhir::Type
  attribute :types, Array[Fhir::Code]
  attribute :references, Array[String]
  attribute :displays, Array[String]
end
