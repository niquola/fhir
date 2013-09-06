# A description of a query with a set of parameters.
class Fhir::Query < Fhir::Resource
  invariants do
    validates_presence_of :identifier
    validates_presence_of :parameters
  end

  # Text summary of the resource, for human interpretation
  attribute :text, Fhir::Narrative

  # Links query and its response(s)
  attribute :identifier, Fhir::URI

  # Set of query parameters with values
  attribute :parameters, Array[Fhir::Extension]

  # If this is a response to a query.
  class Response < Fhir::ValueObject
    invariants do
      validates_presence_of :identifier
      validates_presence_of :outcome
    end

    # Links response to source query
    attribute :identifier, Fhir::URI

    # Outcome of processing the query
    attribute :outcome, Fhir::Code

    # Total number of matching records
    attribute :total, Integer

    # Parameters server used
    attribute :parameters, Array[Fhir::Extension]

    # To get first page (if paged)
    attribute :firsts, Array[Fhir::Extension]

    # To get previous page (if paged)
    attribute :previous, Array[Fhir::Extension]

    # To get next page (if paged)
    attribute :nexts, Array[Fhir::Extension]

    # To get last page (if paged)
    attribute :lasts, Array[Fhir::Extension]

    # Resources that are the results of the search
    resource_references :references, [Fhir::Resource]
  end

  attribute :response, Response
end

