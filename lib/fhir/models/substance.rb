# A homogeneous material with a definite composition used in
# healthcare.
class Fhir::Substance < Fhir::Resource
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
  resource_references :ingredients, [Fhir::Substance]

  # Absolute | Relative
  attribute :quantity_mode, Fhir::CodeableConcept # CodeableConcept
end

