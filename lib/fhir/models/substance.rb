# A homogeneous material with a definite composition used in
# healthcare.
class Fhir::Substance < Fhir::Resource
  # Identifier of the substance
  attribute :identifier, Fhir::Identifier

  # Name of the substance
  # Should be present
  attribute :name, String

  # Type of the substance
  attribute :type, Fhir::CodeableConcept

  # Description of the substance
  attribute :description, String

  # Substance status
  attribute :status, Fhir::CodeableConcept

  # Substance effective period
  attribute :effective_time, Fhir::Period

  # Substance amount
  attribute :quantity, Fhir::Quantity

  # Substance composition
  resource_references :ingredients, [Fhir::Substance]

  # Absolute | Relative
  attribute :quantity_mode, Fhir::CodeableConcept
end

