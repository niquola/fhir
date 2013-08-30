class Fhir::SampledData < Fhir::Type
  attribute :origins, Array[Fhir::Quantity]
  attribute :periods, Array[Fhir::decimal]
  attribute :factors, Array[Fhir::decimal]
  attribute :lower_limits, Array[Fhir::decimal]
  attribute :upper_limits, Array[Fhir::decimal]
  attribute :dimensions, Array[Fhir::integer]
  attribute :data, Array[Fhir::String]
end
