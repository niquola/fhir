# Specific reactions to a substance
class AdverseReaction
  include Virtus
  # Additional Content defined by implementations
  attribute :extension, Extension

  # Text summary of the resource, for human interpretation
  attribute :text, Narrative

  # Contained, inline Resources
  attribute :contained, Resource

  # When the reaction occurred
  attribute :reactionDate, DateTime

  # The subject of the adverse reaction
  attribute :subject, Resource(Patient)

  # To say that a reaction to substance did not occur
  attribute :didNotOccurFlag, boolean

  # Who recorded the reaction
  attribute :recorder, Resource(Practitioner|Patient)

  # The signs and symptoms that were observed as part of the reaction
  attribute :symptom, Symptom

  class Symptom
    include Virtus::ValueObject
    # Indicates the specific sign or symptom that was observed
    attribute :code, CodeableConcept

    # The severity of the sign or symptom
    attribute :severity, code

  end
  # An exposure to a substance that preceded a reaction occurrence
  attribute :exposure, Exposure

  class Exposure
    include Virtus::ValueObject
    # When the exposure occurred
    attribute :exposureDate, DateTime

    # The type of exposure
    attribute :exposureType, code

    # A statement of how confident that the recorder was that this exposure caused the reaction
    attribute :causalityExpectation, code

    # Substance(s) that is presumed to have caused the adverse reaction
    attribute :substance, Resource(Substance)

  end
end
