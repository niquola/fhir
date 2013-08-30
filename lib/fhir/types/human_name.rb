class Fhir::HumanName < Fhir::Type
  attribute :uses, Array[Fhir::Code]
  attribute :texts, Array[Fhir::String]
  attribute :family, Fhir::String
  attribute :given, Fhir::String
  attribute :prefix, Fhir::String
  attribute :suffix, Fhir::String
  attribute :periods, Array[Fhir::Period]
end
