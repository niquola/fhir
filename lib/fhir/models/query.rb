# A description of a query with a set of parameters
class Query
  include Virtus
  # Additional Content defined by implementations
  attribute :extension, Extension

  # Text summary of the resource, for human interpretation
  attribute :text, Narrative

  # Contained, inline Resources
  attribute :contained, Resource

  # Links query and its response(s)
  attribute :identifier, uri

  # Set of query parameters with values
  attribute :parameter, Extension

  # If this is a response to a query
  attribute :response, Response

  class Response
    include Virtus::ValueObject
    # Links response to source query
    attribute :identifier, uri

    # Outcome of processing the query
    attribute :outcome, code

    # Total number of matching records
    attribute :total, integer

    # Parameters server used
    attribute :parameter, Extension

    # To get first page (if paged)
    attribute :first, Extension

    # To get previous page (if paged)
    attribute :previous, Extension

    # To get next page (if paged)
    attribute :next, Extension

    # To get last page (if paged)
    attribute :last, Extension

    # Resources that are the results of the search
    attribute :reference, Resource(Any)

  end
end
