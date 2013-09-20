# Specific reactions to a substance.
class Fhir::AdverseReaction < Fhir::Resource
  invariants do
    validates_presence_of :subject_ref
    validates_inclusion_of :did_not_occur_flag, in: [true, false], message: 'must be either true or false'
  end

  # Text summary of the resource, for human interpretation
  attribute :text, Fhir::Narrative

  # When the reaction occurred
  attribute :reaction_date, DateTime

  # The subject of the adverse reaction
  resource_reference :subject, [Fhir::Patient]

  # To say that a reaction to substance did not occur
  attribute :did_not_occur_flag, Boolean

  # Who recorded the reaction
  resource_reference :recorder, [Fhir::Practitioner, Fhir::Patient]

  # The signs and symptoms that were observed as part of the
  # reaction.
  class Symptom < Fhir::ValueObject
    invariants do
      validates_presence_of :code
    end

    # Indicates the specific sign or symptom that was observed
    attribute :code, Fhir::CodeableConcept

    # The severity of the sign or symptom
    attribute :severity, Fhir::Code
  end

  attribute :symptoms, Array[Symptom]

  # An exposure to a substance that preceded a reaction
  # occurrence.
  class Exposure < Fhir::ValueObject
    # When the exposure occurred
    attribute :exposure_date, DateTime

    # The type of exposure
    attribute :exposure_type, Fhir::Code

    # A statement of how confident that the recorder was that
    # this exposure caused the reaction
    attribute :causality_expectation, Fhir::Code

    # Substance(s) that is presumed to have caused the adverse
    # reaction
    resource_reference :substance, [Fhir::Substance]
  end

  attribute :exposures, Array[Exposure]
end


Fhir.load_handmade('models/adverse_reaction')
