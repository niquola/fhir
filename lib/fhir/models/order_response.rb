# A response to an order.
class Fhir::OrderResponse < Fhir::Resource
  # Additional Content defined by implementations
  attribute :extension, Array[Extension]

  # Text summary of the resource, for human interpretation
  attribute :text, Narrative

  # Contained, inline Resources
  attribute :contained, Array[ResourceLink[Resource]]

  # The order that this is a response to
  # Should be present
  attribute :request, ResourceLink[Order]

  # When the response was made
  attribute :date, dateTime

  # Who made the response
  attribute :who, ResourceLink[Practitioner, Organization]

  # If required by policy
  attribute :authority, ResourceLink[Any]

  # How much the request will/did cost
  attribute :cost, Money

  # The status of the response
  # Should be present
  attribute :code, code

  # Additional description of the response
  attribute :description, string

  # Details of the outcome of performing the order
  attribute :fulfillment, Array[ResourceLink[Any]]
end

