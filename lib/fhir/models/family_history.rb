# Significant health events and conditions for people
# related to the subject relevant in the context of care for
# the subject.
class Fhir::FamilyHistory < Fhir::Resource
  invariants do
    validates_presence_of :subject_ref
  end

  # Text summary of the resource, for human interpretation
  attribute :text, Fhir::Narrative

  # Subject of this history
  resource_reference :subject, [Fhir::Patient]

  # Additional details
  attribute :note, String

  # The related person. Each FamilyHistory resource contains
  # the entire family history for a single person.
  class Relation < Fhir::ValueObject
    invariants do
      validates_presence_of :relationship
    end

    # The family member who had the condition
    attribute :name, String

    # Relationship to the subject
    attribute :relationship, Fhir::CodeableConcept

    # Is the person deceased
    attribute :deceased, *Fhir::Type[Boolean, Fhir::Quantity, Fhir::Range, String]

    # General note about the related person
    attribute :note, String

    # The significant Conditions (or condition) that the family
    # member had. This is a repeating section to allow a system to
    # represent more than one condition per resource, though there
    # is nothing stopping multiple resources - one per condition.
    class Condition < Fhir::ValueObject
      invariants do
        validates_presence_of :type
      end

      # The condition
      attribute :type, Fhir::CodeableConcept

      # deceased | permanent disability | etc.
      attribute :outcome, Fhir::CodeableConcept

      # How old the person was when the condition manifested
      attribute :onset, *Fhir::Type[Fhir::Quantity, Fhir::Range, String]

      # General notes
      attribute :note, String
    end

    attribute :conditions, Array[Condition]
  end

  attribute :relations, Array[Relation]
end


Fhir.load_handmade('models/family_history')
