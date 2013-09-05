# A time period defined by a start and end time.
class Fhir::Period < Fhir::DataType
  # The start of the period
  attribute :start, DateTime

  # The end of the period, if not ongoing
  attribute :end, DateTime
end

