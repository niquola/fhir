# A set of answers to predefined lists of questions. The
# questions may be ordered and grouped into coherent subsets,
# corresponding to the structure of the grouping of the
# underlying questions.
class Fhir::Questionnaire < Fhir::Resource
  # Additional Content defined by implementations
  attribute :extension, Array[Extension]

  # Text summary of the resource, for human interpretation
  attribute :text, Narrative

  # Contained, inline Resources
  attribute :contained, Array[ResourceLink[Resource]]

  # registered|interim|final|amended|cancelled|withdrawn
  # Should be present
  attribute :status, code

  # Date this version was authored
  # Should be present
  attribute :authored, dateTime

  # The subject of the questionnaires
  attribute :subject, ResourceLink[Patient, RelatedPerson]

  # Person that collected the answers
  attribute :author, ResourceLink[Practitioner, Patient, RelatedPerson]

  # The person that answered the questions
  attribute :source, ResourceLink[Patient, Practitioner, RelatedPerson]

  # Name/code for a predefined list of questions
  attribute :name, CodeableConcept

  # Identification of this questionnaire
  attribute :identifier, Identifier

  # Primary encounter during which the answers were collected
  attribute :encounter, ResourceLink[Encounter]

  # Answers to questions on a questionnaire.
  class Question < Fhir::ValueObject
    # Code or name of the question
    attribute :name, CodeableConcept

    # Text of the question
    attribute :text, string

    # Single-valued answer to the question
    attribute :answer[x], decimal

    # Selected options
    attribute :choice, Array[Coding]

    # Valueset containing the possible options
    attribute :options[x], uri

    # Structured answer
    attribute :data[x], *

    # Remarks about the answer given
    attribute :remarks, string
  end

  attribute :question, Array[Question]

  # A group of questions to a possibly similarly grouped set
  # of question in the questionnaire.
  class Group < Fhir::ValueObject
    # Code or name of the section on a questionnaire
    attribute :name, CodeableConcept

    # Header for the group
    attribute :header, string

    # Additional text for the group
    attribute :text, string

    # The subject this group's answers are about
    attribute :subject, ResourceLink[Any]

    # Questions belonging to this group
    attribute :question, Array[@Questionnaire.question]

    # Nested questionnaire group
    attribute :group, Array[@Questionnaire.group]
  end

  attribute :group, Array[Group]
end

