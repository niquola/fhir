class AdverseReaction
  attribute :extension, Extension
  attribute :text, Narrative
  attribute :contained, Resource
  attribute :reactionDate, DateTime
  attribute :subject, Resource(Patient)
  attribute :didNotOccurFlag, boolean
  attribute :recorder, Resource(Practitioner|Patient)
  attribute :symptom, Symptom
  class Symptom
    attribute :code, CodeableConcept
    attribute :severity, code
  end
  attribute :exposure, Exposure
  class Exposure
    attribute :exposureDate, DateTime
    attribute :exposureType, code
    attribute :causalityExpectation, code
    attribute :substance, Resource(Substance)
  end
end
