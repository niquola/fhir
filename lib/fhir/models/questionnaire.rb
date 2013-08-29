class Questionnaire
  include Virtus
  # Additional Content defined by implementations
  attribute :extension, Extension

  # Text summary of the resource, for human interpretation
  attribute :text, Narrative

  # Contained, inline Resources
  attribute :contained, Resource

  # registered|interim|final|amended|cancelled|withdrawn
  attribute :status, code

  # Date this version was authored
  attribute :authored, DateTime

  # The subject of the questionnaires
  attribute :subject, Resource(Patient|RelatedPerson)

  # Person that collected the answers
  attribute :author, Resource(Practitioner|Patient|RelatedPerson)

  # The person that answered the questions
  attribute :source, Resource(Patient|Practitioner|RelatedPerson)

  # Name/code for a predefined list of questions
  attribute :name, CodeableConcept

  # Identification of this questionnaire
  attribute :identifier, Identifier

  # Primary encounter during which the answers were collected
  attribute :encounter, Resource(Encounter)

  # Answers to questions
  attribute :question, Question

  class Question
    include Virtus::ValueObject
    # Code or name of the question
    attribute :name, CodeableConcept

    # Text of the question
    attribute :text, String

    # Single-valued answer to the question
    attribute :answer[x], decimal

    # Selected options
    attribute :choice, Coding

    # Valueset containing the possible options
    attribute :options[x], uri

    # Structured answer
    attribute :data[x], *

    # Remarks about the answer given
    attribute :remarks, String

  end
  # Grouped answers
  attribute :group, Group

  class Group
    include Virtus::ValueObject
    # Code or name of the section on a questionnaire
    attribute :name, CodeableConcept

    # Header for the group
    attribute :header, String

    # Additional text for the group
    attribute :text, String

    # The subject this group's answers are about
    attribute :subject, Resource(Any)

    # Questions belonging to this group
    attribute :question, @Questionnaire.question

    # Nested questionnaire group
    attribute :group, @Questionnaire.group

  end
end
