# A response to an order
class OrderResponse
  include Virtus
  # Additional Content defined by implementations
  attribute :extension, Extension

  # Text summary of the resource, for human interpretation
  attribute :text, Narrative

  # Contained, inline Resources
  attribute :contained, Resource

  # The order that this is a response to
  attribute :request, Resource(Order)

  # When the response was made
  attribute :date, DateTime

  # Who made the response
  attribute :who, Resource(Practitioner|Organization)

  # If required by policy
  attribute :authority, Resource(Any)

  # How much the request will/did cost
  attribute :cost, Money

  # The status of the response
  attribute :code, code

  # Additional description of the response
  attribute :description, String

  # Details of the outcome of performing the order
  attribute :fulfillment, Resource(Any)

end
