class Fhir::Schedule < Fhir::Type
  attribute :event, Fhir::Period
  attribute :repeats, Array[Fhir::]
  attribute :frequencies, Array[Integer]
  attribute :whens, Array[Fhir::Code]
  attribute :durations, Array[Float]
  attribute :units, Array[Fhir::Code]
  attribute :counts, Array[Integer]
  attribute :ends, Array[DateTime]
end
