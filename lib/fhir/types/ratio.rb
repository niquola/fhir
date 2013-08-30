class Fhir::Ratio < Fhir::Type
  attribute :numerators, Array[Fhir::Quantity]
  attribute :denominators, Array[Fhir::Quantity]
end
