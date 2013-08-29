# A homogeneous material with a definite composition used in healthcare
class Substance
  include Virtus
  # Additional Content defined by implementations
  attribute :extension, Extension

  # Text summary of the resource, for human interpretation
  attribute :text, Narrative

  # Contained, inline Resources
  attribute :contained, Resource

  # Identifier of the substance
  attribute :identifier, Identifier

  # Name of the substance
  attribute :name, String

  # Type of the substance
  attribute :type, CodeableConcept

  # Description of the substance
  attribute :description, String

  # Substance status
  attribute :status, CodeableConcept

  # Substance effective period
  attribute :effectiveTime, Period

  # Substance amount
  attribute :quantity, Quantity

  # Substance composition
  attribute :ingredient, Resource(Substance)

  # Absolute | Relative
  attribute :quantityMode, CodeableConcept

end
