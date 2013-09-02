# Allergy/Intolerance.
class Fhir::AllergyIntolerance < Fhir::Resource
  # Additional Content defined by implementations
  attribute :extensions, Array[Fhir::Extension] # Extension

  # Text summary of the resource, for human interpretation
  attribute :text, Fhir::Narrative # Narrative

  # Contained, inline Resources
  attribute :containeds, Array[Fhir::Resource] # Resource

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
  attribute :subject, Fhir::ResourceReference[Fhir::Patient] # Resource(Patient)

  # Who recorded the sensitivity
  attribute :recorder, Fhir::ResourceReference[Fhir::Practitioner, Fhir::Patient] # Resource(Practitioner|Patient)

  # The substance that causes the sensitivity
  # Should be present
  attribute :substance, Fhir::Substance # Resource(Substance)
  # attribute :substance, Fhir::ResourceReference[Fhir::Substance] # Resource(Substance)

  # Reactions associated with the sensitivity
  attribute :reactions, Array[Fhir::ResourceReference[Fhir::AdverseReaction]] # Resource(AdverseReaction)

  # Observations that confirm or refute the sensitivity
  attribute :sensitivity_tests, Array[Fhir::ResourceReference[Fhir::Observation]] # Resource(Observation)
end

