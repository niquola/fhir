class AllergyIntolerance
  attribute :extension, Extension
  attribute :text, Narrative
  attribute :contained, Resource
  attribute :identifier, Identifier
  attribute :criticality, code
  attribute :sensitivityType, code
  attribute :recordedDate, DateTime
  attribute :status, code
  attribute :subject, Resource(Patient)
  attribute :recorder, Resource(Practitioner|Patient)
  attribute :substance, Resource(Substance)
  attribute :reaction, Resource(AdverseReaction)
  attribute :sensitivityTest, Resource(Observation)
end
