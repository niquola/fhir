# Significant health events and conditions for people
# related to the subject relevant in the context of care for
# the subject.
class Fhir::FamilyHistory < Fhir::Resource
  # Additional Content defined by implementations
  attribute :extension, Array[Fhir::Extension] # Extension

  # Text summary of the resource, for human interpretation
  attribute :text, Fhir::Narrative # Narrative

  # Contained, inline Resources
  attribute :contained, Array[Fhir::Resource] # Resource

  # Subject of this history
  # Should be present
  attribute :subject, Fhir::ResourceReference[Fhir::Patient] # Resource(Patient)

  # Additional details
  attribute :note, String # string

  # The related person. Each FamilyHistory resource contains
  # the entire family history for a single person.
  class Relation < Fhir::ValueObject
    # The family member who had the condition
    attribute :name, String # string

    # Relationship to the subject
    # Should be present
    attribute :relationship, Fhir::CodeableConcept # CodeableConcept

    # Is the person deceased
    attribute :deceased, Boolean # boolean

    # General note about the related person
    attribute :note, String # string

    # The significant Conditions (or condition) that the family
    # member had. This is a repeating section to allow a system to
    # represent more than one condition per resource, though there
    # is nothing stopping multiple resources - one per condition.
    class Condition < Fhir::ValueObject
      # The condition
      # Should be present
      attribute :type, Fhir::CodeableConcept # CodeableConcept

      # deceased | permanent disability | etc.
      attribute :outcome, Fhir::CodeableConcept # CodeableConcept

      # How old the person was when the condition manifested
      attribute :onset, Fhir::Quantity # Age

      # General notes
      attribute :note, String # string
    end

    attribute :condition, Array[Condition] # 
  end

  attribute :relation, Array[Relation] # 
end

