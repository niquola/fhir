# A description of a query with a set of parameters.
class Fhir::Query < Fhir::Resource
  # Links query and its response(s)
  # Should be present
  attribute :identifier, Fhir::URI # uri

  # Set of query parameters with values
  # Should be present
  attribute :parameters, Array[Fhir::Extension] # Extension

  # If this is a response to a query.
  class Response < Fhir::ValueObject
    # Links response to source query
    # Should be present
    attribute :identifier, Fhir::URI # uri

    # Outcome of processing the query
    # Should be present
    attribute :outcome, Fhir::Code # code

    # Total number of matching records
    attribute :total, Integer # integer

    # Parameters server used
    attribute :parameters, Array[Fhir::Extension] # Extension

    # To get first page (if paged)
    attribute :firsts, Array[Fhir::Extension] # Extension

    # To get previous page (if paged)
    attribute :previous, Array[Fhir::Extension] # Extension

    # To get next page (if paged)
    attribute :nexts, Array[Fhir::Extension] # Extension

    # To get last page (if paged)
    attribute :lasts, Array[Fhir::Extension] # Extension

    # Resources that are the results of the search
    resource_references :references, [Fhir::Resource]
  end

  attribute :response, Response # 
end

