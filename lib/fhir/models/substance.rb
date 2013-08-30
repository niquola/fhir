# A homogeneous material with a definite composition used in
# healthcare.
class Fhir::Substance < Fhir::Resource
  # Additional Content defined by implementations
  attribute :extension, Array[Fhir::Extension] # Extension

  # Text summary of the resource, for human interpretation
  attribute :text, Fhir::Narrative # Narrative

  # Contained, inline Resources
  attribute :contained, Array[Fhir::Resource] # Resource

  # Identifier of the substance
  attribute :identifier, Fhir::Identifier # Identifier

  # Name of the substance
  # Should be present
  attribute :name, String # string

  # Type of the substance
  attribute :type, Fhir::CodeableConcept # CodeableConcept

  # Description of the substance
  attribute :description, String # string

  # Substance status
  attribute :status, Fhir::CodeableConcept # CodeableConcept

  # Substance effective period
  attribute :effective_time, Fhir::Period # Period

  # Substance amount
  attribute :quantity, Fhir::Quantity # Quantity

  # Substance composition
  attribute :ingredient, Array[Fhir::ResourceReference[Fhir::Substance]] # Resource(Substance)

  # Absolute | Relative
  attribute :quantity_mode, Fhir::CodeableConcept # CodeableConcept
end

