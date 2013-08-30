class Fhir::Range < Fhir::Type
  attribute :lows, Array[Fhir::Quantity]
  attribute :highs, Array[Fhir::Quantity]
end
