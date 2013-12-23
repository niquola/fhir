# A set of ordered Quantities defined by a low and high
# limit.
class Fhir::Range < Fhir::DataType
  # Low limit
  attribute :low, Fhir::Quantity

  # High limit
  attribute :high, Fhir::Quantity
end

Fhir.load_extension('range')
