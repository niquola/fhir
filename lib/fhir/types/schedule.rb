class Fhir::Schedule < Fhir::Type
  attribute :event, Fhir::Period
  attribute :repeats, Array[Fhir::]
  attribute :frequencies, Array[Fhir::integer]
  attribute :whens, Array[Fhir::Code]
  attribute :durations, Array[Fhir::decimal]
  attribute :units, Array[Fhir::Code]
  attribute :counts, Array[Fhir::integer]
  attribute :ends, Array[Fhir::dateTime]
end
