# A series of measurements taken by a device, with upper and
# lower limits. There may be more than one dimension in the
# data.
class Fhir::SampledData < Fhir::Type
  # Zero value and units
  attribute :origin, Fhir::Quantity # Quantity

  # Number of milliseconds between samples
  attribute :period, Float # decimal

  # Multiply data by this before adding to origin
  attribute :factor, Float # decimal

  # Lower limit of detection
  attribute :lower_limit, Float # decimal

  # Upper limit of detection
  attribute :upper_limit, Float # decimal

  # Number of sample points at each time point
  attribute :dimensions, Integer # integer

  # Decimal values with spaces, or "E" | "U" | "L"
  attribute :data, String # string
end

