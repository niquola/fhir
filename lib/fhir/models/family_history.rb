# Significant health events and conditions for people
# related to the subject relevant in the context of care for
# the subject.
class Fhir::FamilyHistory < Fhir::Resource
  invariants do
    validates_presence_of :subject_ref
  end

  # Extensions that cannot be ignored
  attribute :modifier_extension, Array[Fhir::Extension]

  # Text summary of the resource, for human interpretation
  attribute :text, Fhir::Narrative

  # External Id(s) for this record
  attribute :identifier, Array[Fhir::Identifier]

  # Patient history is about
  resource_reference :subject, [Fhir::Patient]

  # Additional details not covered elsewhere
  attribute :note, String

  # The related person. Each FamilyHistory resource contains
  # the entire family history for a single person.
  class Relation < Fhir::ValueObject
    invariants do
      validates_presence_of :relationship
    end

    # Extensions that cannot be ignored
    attribute :modifier_extension, Array[Fhir::Extension]

    # The family member described
    attribute :name, String

    # Relationship to the subject
    attribute :relationship, Fhir::CodeableConcept

    # (approximate) date of birth
    attribute :born, *Fhir::Type[Fhir::Period, Date, String]

    # Dead? How old/when?
    attribute :deceased, *Fhir::Type[Boolean, Fhir::Quantity, Fhir::Range, Date, String]

    # General note about related person
    attribute :note, String

    # The significant Conditions (or condition) that the family
    # member had. This is a repeating section to allow a system to
    # represent more than one condition per resource, though there
    # is nothing stopping multiple resources - one per condition.
    class Condition < Fhir::ValueObject
      invariants do
        validates_presence_of :type
      end

      # Extensions that cannot be ignored
      attribute :modifier_extension, Array[Fhir::Extension]

      # Condition suffered by relation
      attribute :type, Fhir::CodeableConcept

      # deceased | permanent disability | etc.
      attribute :outcome, Fhir::CodeableConcept

      # When condition first manifested
      attribute :onset, *Fhir::Type[Fhir::Quantity, Fhir::Range, String]

      # Extra information about condition
      attribute :note, String
    end

    attribute :condition, Array[Condition]
  end

  attribute :relation, Array[Relation]
end


Fhir.load_extension('family_history')
