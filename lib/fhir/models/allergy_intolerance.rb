class AllergyIntolerance
  include Virtus
  # Additional Content defined by implementations
  attribute :extension, Extension

  # Text summary of the resource, for human interpretation
  attribute :text, Narrative

  # Contained, inline Resources
  attribute :contained, Resource

  # An external identifier for the sensitivity
  attribute :identifier, Identifier

  # Criticality of the sensitivity
  attribute :criticality, code

  # Type of the sensitivity
  attribute :sensitivityType, code

  # Date when the sensitivity was recorded
  attribute :recordedDate, DateTime

  # Status of the sensitivity
  attribute :status, code

  # Who the sensitivity is for
  attribute :subject, Resource(Patient)

  # Who recorded the sensitivity
  attribute :recorder, Resource(Practitioner|Patient)

  # The substance that causes the sensitivity
  attribute :substance, Resource(Substance)

  # Reactions associated with the sensitivity
  attribute :reaction, Resource(AdverseReaction)

  # Observations that confirm or refute the sensitivity
  attribute :sensitivityTest, Resource(Observation)

end
