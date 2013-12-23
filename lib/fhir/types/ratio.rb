# A ratio of two Quantity values - a numerator and a
# denominator.
class Fhir::Ratio < Fhir::DataType
  # Numerator value
  attribute :numerator, Fhir::Quantity

  # Denominator value
  attribute :denominator, Fhir::Quantity
end

Fhir.load_extension('ratio')
