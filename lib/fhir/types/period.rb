class Fhir::Period < Fhir::Type
  attribute :starts, Array[Fhir::dateTime]
  attribute :ends, Array[Fhir::dateTime]
end
