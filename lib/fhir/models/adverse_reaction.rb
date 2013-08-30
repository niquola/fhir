# Specific reactions to a substance.
class Fhir::AdverseReaction < Fhir::Resource
  # Additional Content defined by implementations
  attribute :extension, Array[Extension]

  # Text summary of the resource, for human interpretation
  attribute :text, Narrative

  # Contained, inline Resources
  attribute :contained, Array[ResourceLink[Resource]]

  # When the reaction occurred
  attribute :reaction_date, dateTime

  # The subject of the adverse reaction
  # Should be present
  attribute :subject, ResourceLink[Patient]

  # To say that a reaction to substance did not occur
  # Should be present
  attribute :did_not_occur_flag, boolean

  # Who recorded the reaction
  attribute :recorder, ResourceLink[Practitioner, Patient]

  # The signs and symptoms that were observed as part of the
  # reaction.
  class Symptom < Fhir::ValueObject
    # Indicates the specific sign or symptom that was observed
    # Should be present
    attribute :code, CodeableConcept

    # The severity of the sign or symptom
    attribute :severity, code
  end

  attribute :symptom, Array[Symptom]

  # An exposure to a substance that preceded a reaction
  # occurrence.
  class Exposure < Fhir::ValueObject
    # When the exposure occurred
    attribute :exposure_date, dateTime

    # The type of exposure
    attribute :exposure_type, code

    # A statement of how confident that the recorder was that
    # this exposure caused the reaction
    attribute :causality_expectation, code

    # Substance(s) that is presumed to have caused the adverse
    # reaction
    attribute :substance, ResourceLink[Substance]
  end

  attribute :exposure, Array[Exposure]
end

