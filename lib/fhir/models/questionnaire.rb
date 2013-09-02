# A set of answers to predefined lists of questions. The
# questions may be ordered and grouped into coherent subsets,
# corresponding to the structure of the grouping of the
# underlying questions.
class Fhir::Questionnaire < Fhir::Resource
  # Additional Content defined by implementations
  attribute :extensions, Array[Fhir::Extension] # Extension

  # Text summary of the resource, for human interpretation
  attribute :text, Fhir::Narrative # Narrative

  # Contained, inline Resources
  attribute :containeds, Array[Fhir::Resource] # Resource

  # registered|interim|final|amended|cancelled|withdrawn
  # Should be present
  attribute :status, Fhir::Code # code

  # Date this version was authored
  # Should be present
  attribute :authored, DateTime # dateTime

  # The subject of the questionnaires
  attribute :subject, Fhir::ResourceReference[Fhir::Patient, Fhir::RelatedPerson] # Resource(Patient|RelatedPerson)

  # Person that collected the answers
  attribute :author, Fhir::ResourceReference[Fhir::Practitioner, Fhir::Patient, Fhir::RelatedPerson] # Resource(Practitioner|Patient|RelatedPerson)

  # The person that answered the questions
  attribute :source, Fhir::ResourceReference[Fhir::Patient, Fhir::Practitioner, Fhir::RelatedPerson] # Resource(Patient|Practitioner|RelatedPerson)

  # Name/code for a predefined list of questions
  attribute :name, Fhir::CodeableConcept # CodeableConcept

  # Identification of this questionnaire
  attribute :identifier, Fhir::Identifier # Identifier

  # Primary encounter during which the answers were collected
  attribute :encounter, Fhir::ResourceReference[Fhir::Encounter] # Resource(Encounter)

  # Answers to questions on a questionnaire.
  class Question < Fhir::ValueObject
    # Code or name of the question
    attribute :name, Fhir::CodeableConcept # CodeableConcept

    # Text of the question
    attribute :text, String # string

    # Single-valued answer to the question
    attribute :answer, Float # decimal

    # Selected options
    attribute :choices, Array[Fhir::Coding] # Coding

    # Valueset containing the possible options
    attribute :options, Fhir::URI # uri

    # Structured answer
    attribute :data, Object # *

    # Remarks about the answer given
    attribute :remarks, String # string
  end

  attribute :questions, Array[Question] # 

  # A group of questions to a possibly similarly grouped set
  # of question in the questionnaire.
  class Group < Fhir::ValueObject
    # Code or name of the section on a questionnaire
    attribute :name, Fhir::CodeableConcept # CodeableConcept

    # Header for the group
    attribute :header, String # string

    # Additional text for the group
    attribute :text, String # string

    # The subject this group's answers are about
    attribute :subject, Fhir::ResourceReference # Resource(Any)

    # Questions belonging to this group
    attribute :questions, Array[Fhir::Questionnaire::Question] # @Questionnaire.question

    # Nested questionnaire group
    attribute :groups, Array[Fhir::Questionnaire::Group] # @Questionnaire.group
  end

  attribute :groups, Array[Group] # 
end

