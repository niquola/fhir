# A response to an order.
class Fhir::OrderResponse < Fhir::Resource
  invariants do
    validates_presence_of :request_ref
    validates_presence_of :code
  end

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

  # The status of the response
  attribute :code, Fhir::Code

  # Additional description of the response
  attribute :description, String

  # Details of the outcome of performing the order
  resource_references :fulfillments, [Fhir::Resource]
end

