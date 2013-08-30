# A homogeneous material with a definite composition used in
# healthcare.
class Fhir::Substance < Fhir::Resource
  # Additional Content defined by implementations
  attribute :extension, Array[Extension]

  # Text summary of the resource, for human interpretation
  attribute :text, Narrative

  # Contained, inline Resources
  attribute :contained, Array[ResourceLink[Resource]]

  # Identifier of the substance
  attribute :identifier, Identifier

  # Name of the substance
  # Should be present
  attribute :name, string

  # Type of the substance
  attribute :type, CodeableConcept

  # Description of the substance
  attribute :description, string

  # Substance status
  attribute :status, CodeableConcept

  # Substance effective period
  attribute :effective_time, Period

  # Substance amount
  attribute :quantity, Quantity

  # Substance composition
  attribute :ingredient, Array[ResourceLink[Substance]]

  # Absolute | Relative
  attribute :quantity_mode, CodeableConcept
end

