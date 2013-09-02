# A response to an order.
class Fhir::OrderResponse < Fhir::Resource
  # Additional Content defined by implementations
  attribute :extensions, Array[Fhir::Extension] # Extension

  # Text summary of the resource, for human interpretation
  attribute :text, Fhir::Narrative # Narrative

  # Contained, inline Resources
  attribute :containeds, Array[Fhir::Resource] # Resource

  # The order that this is a response to
  # Should be present
  attribute :request, Fhir::ResourceReference[Fhir::Order] # Resource(Order)

  # When the response was made
  attribute :date, DateTime # dateTime

  # Who made the response
  attribute :who, Fhir::ResourceReference[Fhir::Practitioner, Fhir::Organization] # Resource(Practitioner|Organization)

  # If required by policy
  attribute :authority, Fhir::ResourceReference # Resource(Any)

  # How much the request will/did cost
  attribute :cost, Fhir::Money # Money

  # The status of the response
  # Should be present
  attribute :code, Fhir::Code # code

  # Additional description of the response
  attribute :description, String # string

  # Details of the outcome of performing the order
  attribute :fulfillments, Array[Fhir::ResourceReference] # Resource(Any)
end

