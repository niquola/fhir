class Questionnaire
  attribute :extension, Extension
  attribute :text, Narrative
  attribute :contained, Resource
  attribute :status, code
  attribute :authored, DateTime
  attribute :subject, Resource(Patient|RelatedPerson)
  attribute :author, Resource(Practitioner|Patient|RelatedPerson)
  attribute :source, Resource(Patient|Practitioner|RelatedPerson)
  attribute :name, CodeableConcept
  attribute :identifier, Identifier
  attribute :encounter, Resource(Encounter)
  attribute :question, Question
  class Question
    attribute :name, CodeableConcept
    attribute :text, String
    attribute :answer[x], decimal
    attribute :choice, Coding
    attribute :options[x], uri
    attribute :data[x], *
    attribute :remarks, String
  end
  attribute :group, Group
  class Group
    attribute :name, CodeableConcept
    attribute :header, String
    attribute :text, String
    attribute :subject, Resource(Any)
    attribute :question, @Questionnaire.question
    attribute :group, @Questionnaire.group
  end
end
