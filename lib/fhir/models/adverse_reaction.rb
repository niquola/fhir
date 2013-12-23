# Specific reactions to a substance.
class Fhir::AdverseReaction < Fhir::Resource
  invariants do
    validates_presence_of :subject_ref
    validates_inclusion_of :did_not_occur_flag, in: [true, false], message: 'must be either true or false'
  end

  # Extensions that cannot be ignored
  attribute :modifier_extension, Array[Fhir::Extension]

  # Text summary of the resource, for human interpretation
  attribute :text, Fhir::Narrative

  # External Ids for this adverse reaction
  attribute :identifier, Array[Fhir::Identifier]

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

    # Extensions that cannot be ignored
    attribute :modifier_extension, Array[Fhir::Extension]

    # Indicates the specific sign or symptom that was observed
    attribute :code, Fhir::CodeableConcept

    # severe | serious | moderate | minor
    attribute :severity, Fhir::Code
  end

  attribute :symptom, Array[Symptom]

  # An exposure to a substance that preceded a reaction
  # occurrence.
  class Exposure < Fhir::ValueObject
    # Extensions that cannot be ignored
    attribute :modifier_extension, Array[Fhir::Extension]

    # When the exposure occurred
    attribute :exposure_date, DateTime

    # drugadmin | immuniz | coincidental
    attribute :exposure_type, Fhir::Code

    # likely | unlikely | confirmed | unknown
    attribute :causality_expectation, Fhir::Code

    # Presumed causative substance
    resource_reference :substance, [Fhir::Substance]
  end

  attribute :exposure, Array[Exposure]
end


Fhir.load_extension('adverse_reaction')
