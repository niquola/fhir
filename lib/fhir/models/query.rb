class Query
  attribute :extension, Extension
  attribute :text, Narrative
  attribute :contained, Resource
  attribute :identifier, uri
  attribute :parameter, Extension
  attribute :response, Response
  class Response
    attribute :identifier, uri
    attribute :outcome, code
    attribute :total, integer
    attribute :parameter, Extension
    attribute :first, Extension
    attribute :previous, Extension
    attribute :next, Extension
    attribute :last, Extension
    attribute :reference, Resource(Any)
  end
end
