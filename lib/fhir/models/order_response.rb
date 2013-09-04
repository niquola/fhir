# A response to an order.
class Fhir::OrderResponse < Fhir::Resource
  # The order that this is a response to
  # Should be present
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
  # Should be present
  attribute :code, Fhir::Code

  # Additional description of the response
  attribute :description, String

  # Details of the outcome of performing the order
  resource_references :fulfillments, [Fhir::Resource]
end

