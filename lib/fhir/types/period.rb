class Fhir::Period < Fhir::Type
  attribute :starts, Array[DateTime]
  attribute :ends, Array[DateTime]
end
