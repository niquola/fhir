# Allergy/Intolerance.
class Fhir::AllergyIntolerance < Fhir::Resource
  invariants do
    validates_presence_of :sensitivity_type
    validates_presence_of :status
    validates_presence_of :subject
    validates_presence_of :substance
  end

  # An external identifier for the sensitivity
  attribute :identifier, Fhir::Identifier

  # Criticality of the sensitivity
  attribute :criticality, Fhir::Code

  # Type of the sensitivity
  # Should be present
  attribute :sensitivity_type, Fhir::Code

  # Date when the sensitivity was recorded
  attribute :recorded_date, DateTime

  # Status of the sensitivity
  # Should be present
  attribute :status, Fhir::Code

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

