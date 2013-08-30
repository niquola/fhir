class Fhir::Contact < Fhir::Type
  attribute :systems, Array[Fhir::Code]
  attribute :values, Array[Fhir::String]
  attribute :uses, Array[Fhir::Code]
  attribute :periods, Array[Fhir::Period]
end
