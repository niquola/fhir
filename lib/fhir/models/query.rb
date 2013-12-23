# A description of a query with a set of parameters.
class Fhir::Query < Fhir::Resource
  invariants do
    validates_presence_of :identifier
    validates_presence_of :parameter
  end

  # Extensions that cannot be ignored
  attribute :modifier_extension, Array[Fhir::Extension]

  # Text summary of the resource, for human interpretation
  attribute :text, Fhir::Narrative

  # Links query and its response(s)
  attribute :identifier, Fhir::URI

  # Set of query parameters with values
  attribute :parameter, Array[Fhir::Extension]

  # If this is a response to a query.
  class Response < Fhir::ValueObject
    invariants do
      validates_presence_of :identifier
      validates_presence_of :outcome
    end

    # Extensions that cannot be ignored
    attribute :modifier_extension, Array[Fhir::Extension]

    # Links response to source query
    attribute :identifier, Fhir::URI

    # ok | limited | refused | error
    attribute :outcome, Fhir::Code

    # Total number of matching records
    attribute :total, Integer

    # Parameters server used
    attribute :parameter, Array[Fhir::Extension]

    # To get first page (if paged)
    attribute :first, Array[Fhir::Extension]

    # To get previous page (if paged)
    attribute :previous, Array[Fhir::Extension]

    # To get next page (if paged)
    attribute :next, Array[Fhir::Extension]

    # To get last page (if paged)
    attribute :last, Array[Fhir::Extension]

    # Resources that are the results of the search
    resource_references :reference, [Fhir::Resource]
  end

  attribute :response, Response
end


Fhir.load_extension('query')
