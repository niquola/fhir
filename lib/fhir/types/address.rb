class Fhir::Address < Fhir::Type
  attribute :uses, Array[Fhir::Code]
  attribute :texts, Array[String]
  attribute :line, String
  attribute :cities, Array[String]
  attribute :states, Array[String]
  attribute :zips, Array[String]
  attribute :countries, Array[String]
  attribute :periods, Array[Fhir::Period]
end
