class OrderResponse
  attribute :extension, Extension
  attribute :text, Narrative
  attribute :contained, Resource
  attribute :request, Resource(Order)
  attribute :date, DateTime
  attribute :who, Resource(Practitioner|Organization)
  attribute :authority, Resource(Any)
  attribute :cost, Money
  attribute :code, code
  attribute :description, String
  attribute :fulfillment, Resource(Any)
end
