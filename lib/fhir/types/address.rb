class Fhir::Address < Fhir::Type
  attribute :uses, Array[Fhir::Code]
  attribute :texts, Array[Fhir::String]
  attribute :line, Fhir::String
  attribute :cities, Array[Fhir::String]
  attribute :states, Array[Fhir::String]
  attribute :zips, Array[Fhir::String]
  attribute :countries, Array[Fhir::String]
  attribute :periods, Array[Fhir::Period]
end
