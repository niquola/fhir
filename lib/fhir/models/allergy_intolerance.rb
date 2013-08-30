# Allergy/Intolerance.
class Fhir::AllergyIntolerance < Fhir::Resource
  # Additional Content defined by implementations
  attribute :extension, Array[Extension]

  # Text summary of the resource, for human interpretation
  attribute :text, Narrative

  # Contained, inline Resources
  attribute :contained, Array[ResourceLink[Resource]]

  # An external identifier for the sensitivity
  attribute :identifier, Identifier

  # Criticality of the sensitivity
  attribute :criticality, code

  # Type of the sensitivity
  # Should be present
  attribute :sensitivity_type, code

  # Date when the sensitivity was recorded
  attribute :recorded_date, dateTime

  # Status of the sensitivity
  # Should be present
  attribute :status, code

  # Who the sensitivity is for
  # Should be present
  attribute :subject, ResourceLink[Patient]

  # Who recorded the sensitivity
  attribute :recorder, ResourceLink[Practitioner, Patient]

  # The substance that causes the sensitivity
  # Should be present
  attribute :substance, ResourceLink[Substance]

  # Reactions associated with the sensitivity
  attribute :reaction, Array[ResourceLink[AdverseReaction]]

  # Observations that confirm or refute the sensitivity
  attribute :sensitivity_test, Array[ResourceLink[Observation]]
end

