# A time period defined by a start and end time.
class Fhir::Period < Fhir::Type
  # The start of the period
  attribute :start, DateTime # dateTime

  # The end of the period, if not ongoing
  attribute :end, DateTime # dateTime
end

