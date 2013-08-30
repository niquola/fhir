# Significant health events and conditions for people
# related to the subject relevant in the context of care for
# the subject.
class Fhir::FamilyHistory < Fhir::Resource
  # Additional Content defined by implementations
  attribute :extension, Array[Extension]

  # Text summary of the resource, for human interpretation
  attribute :text, Narrative

  # Contained, inline Resources
  attribute :contained, Array[ResourceLink[Resource]]

  # Subject of this history
  # Should be present
  attribute :subject, ResourceLink[Patient]

  # Additional details
  attribute :note, string

  # The related person. Each FamilyHistory resource contains
  # the entire family history for a single person.
  class Relation < Fhir::ValueObject
    # The family member who had the condition
    attribute :name, string

    # Relationship to the subject
    # Should be present
    attribute :relationship, CodeableConcept

    # Is the person deceased
    attribute :deceased[x], boolean

    # General note about the related person
    attribute :note, string

    # The significant Conditions (or condition) that the family
    # member had. This is a repeating section to allow a system to
    # represent more than one condition per resource, though there
    # is nothing stopping multiple resources - one per condition.
    class Condition < Fhir::ValueObject
      # The condition
      # Should be present
      attribute :type, CodeableConcept

      # deceased | permanent disability | etc.
      attribute :outcome, CodeableConcept

      # How old the person was when the condition manifested
      attribute :onset[x], Age

      # General notes
      attribute :note, string
    end

    attribute :condition, Array[Condition]
  end

  attribute :relation, Array[Relation]
end

