# Family History
class FamilyHistory
  include Virtus
  # Additional Content defined by implementations
  attribute :extension, Extension

  # Text summary of the resource, for human interpretation
  attribute :text, Narrative

  # Contained, inline Resources
  attribute :contained, Resource

  # Subject of this history
  attribute :subject, Resource(Patient)

  # Additional details
  attribute :note, String

  # The relation
  attribute :relation, Relation

  class Relation
    include Virtus::ValueObject
    # The family member who had the condition
    attribute :name, String

    # Relationship to the subject
    attribute :relationship, CodeableConcept

    # Is the person deceased
    attribute :deceased[x], boolean

    # General note about the related person
    attribute :note, String

    # The Condition that the related person had
    attribute :condition, Condition

    class Condition
      include Virtus::ValueObject
      # The condition
      attribute :type, CodeableConcept

      # deceased | permanent disability | etc.
      attribute :outcome, CodeableConcept

      # How old the person was when the condition manifested
      attribute :onset[x], Age

      # General notes
      attribute :note, String

    end
  end
end
