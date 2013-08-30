# A description of a query with a set of parameters.
class Fhir::Query < Fhir::Resource
  # Additional Content defined by implementations
  attribute :extension, Array[Extension]

  # Text summary of the resource, for human interpretation
  attribute :text, Narrative

  # Contained, inline Resources
  attribute :contained, Array[ResourceLink[Resource]]

  # Links query and its response(s)
  # Should be present
  attribute :identifier, uri

  # Set of query parameters with values
  # Should be present
  attribute :parameter, Array[Extension]

  # If this is a response to a query.
  class Response < Fhir::ValueObject
    # Links response to source query
    # Should be present
    attribute :identifier, uri

    # Outcome of processing the query
    # Should be present
    attribute :outcome, code

    # Total number of matching records
    attribute :total, integer

    # Parameters server used
    attribute :parameter, Array[Extension]

    # To get first page (if paged)
    attribute :first, Array[Extension]

    # To get previous page (if paged)
    attribute :previous, Array[Extension]

    # To get next page (if paged)
    attribute :next, Array[Extension]

    # To get last page (if paged)
    attribute :last, Array[Extension]

    # Resources that are the results of the search
    attribute :reference, Array[ResourceLink[Any]]
  end

  attribute :response, Response
end

