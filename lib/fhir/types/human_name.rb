class Fhir::HumanName < Fhir::Type
  attribute :uses, Array[Fhir::Code]
  attribute :texts, Array[String]
  attribute :family, String
  attribute :given, String
  attribute :prefix, String
  attribute :suffix, String
  attribute :periods, Array[Fhir::Period]
end
