# A ratio of two Quantity values - a numerator and a
# denominator.
class Fhir::Ratio < Fhir::Type
  # The numerator
  attribute :numerator, Fhir::Quantity # Quantity

  # The denominator
  attribute :denominator, Fhir::Quantity # Quantity
end

