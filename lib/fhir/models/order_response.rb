# A response to an order.
class Fhir::OrderResponse < Fhir::Resource
  invariants do
    validates_presence_of :request_ref
    validates_presence_of :code
  end

  # Extensions that cannot be ignored
  attribute :modifier_extension, Array[Fhir::Extension]

  # Text summary of the resource, for human interpretation
  attribute :text, Fhir::Narrative

  # The order that this is a response to
  resource_reference :request, [Fhir::Order]

  # When the response was made
  attribute :date, DateTime

  # Who made the response
  resource_reference :who, [Fhir::Practitioner, Fhir::Organization]

  # If required by policy
  resource_reference :authority, [Fhir::Resource]

  # How much the request will/did cost
  attribute :cost, Fhir::Money

  # pending | review | rejected | error | accepted | cancelled
  # | aborted | complete
  attribute :code, Fhir::Code

  # Additional description of the response
  attribute :description, String

  # Details of the outcome of performing the order
  resource_references :fulfillment, [Fhir::Resource]
end


Fhir.load_extension('order_response')
