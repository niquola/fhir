# A time period defined by a start and end time.
class Fhir::Period < Fhir::DataType
  # Starting time with inclusive boundary
  attribute :start, DateTime

  # End time with inclusive boundary, if not ongoing
  attribute :end, DateTime
end

Fhir.load_extension('period')
