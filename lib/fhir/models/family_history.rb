class FamilyHistory
  attribute :extension, Extension
  attribute :text, Narrative
  attribute :contained, Resource
  attribute :subject, Resource(Patient)
  attribute :note, String
  attribute :relation, Relation
  class Relation
    attribute :name, String
    attribute :relationship, CodeableConcept
    attribute :deceased[x], boolean
    attribute :note, String
    attribute :condition, Condition
    class Condition
      attribute :type, CodeableConcept
      attribute :outcome, CodeableConcept
      attribute :onset[x], Age
      attribute :note, String
    end
  end
end
