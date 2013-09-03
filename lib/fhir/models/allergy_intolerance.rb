# Allergy/Intolerance.
class Fhir::AllergyIntolerance < Fhir::Resource
  # An external identifier for the sensitivity
  attribute :identifier, Fhir::Identifier # Identifier

  # Criticality of the sensitivity
  attribute :criticality, Fhir::Code # code

  # Type of the sensitivity
  # Should be present
  attribute :sensitivity_type, Fhir::Code # code

  # Date when the sensitivity was recorded
  attribute :recorded_date, DateTime # dateTime

  # Status of the sensitivity
  # Should be present
  attribute :status, Fhir::Code # code

  # Who the sensitivity is for
  # Should be present
  resource_reference :subject, [Fhir::Patient]

  # Who recorded the sensitivity
  resource_reference :recorder, [Fhir::Practitioner, Fhir::Patient]

  # The substance that causes the sensitivity
  # Should be present
  resource_reference :substance, [Fhir::Substance]

  # Reactions associated with the sensitivity
  resource_references :reactions, [Fhir::AdverseReaction]

  # Observations that confirm or refute the sensitivity
  resource_references :sensitivity_tests, [Fhir::Observation]
end

