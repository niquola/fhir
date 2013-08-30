# A set of ordered Quantities defined by a low and high
# limit.
class Fhir::Range < Fhir::Type
  # Low limit
  attribute :low, Fhir::Quantity # Quantity

  # High limit
  attribute :high, Fhir::Quantity # Quantity
end

