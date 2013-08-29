class Substance
  attribute :extension, Extension
  attribute :text, Narrative
  attribute :contained, Resource
  attribute :identifier, Identifier
  attribute :name, String
  attribute :type, CodeableConcept
  attribute :description, String
  attribute :status, CodeableConcept
  attribute :effectiveTime, Period
  attribute :quantity, Quantity
  attribute :ingredient, Resource(Substance)
  attribute :quantityMode, CodeableConcept
end
