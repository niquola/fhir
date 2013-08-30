class Fhir::SampledData < Fhir::Type
  attribute :origins, Array[Fhir::Quantity]
  attribute :periods, Array[Float]
  attribute :factors, Array[Float]
  attribute :lower_limits, Array[Float]
  attribute :upper_limits, Array[Float]
  attribute :dimensions, Array[Integer]
  attribute :data, Array[String]
end
