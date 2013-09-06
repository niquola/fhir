# A set of answers to predefined lists of questions. The
# questions may be ordered and grouped into coherent subsets,
# corresponding to the structure of the grouping of the
# underlying questions.
class Fhir::Questionnaire < Fhir::Resource
  invariants do
    validates_presence_of :status
    validates_presence_of :authored
  end

  # Text summary of the resource, for human interpretation
  attribute :text, Fhir::Narrative

  # registered|interim|final|amended|cancelled|withdrawn
  # Should be present
  attribute :status, Fhir::Code

  # Date this version was authored
  # Should be present
  attribute :authored, DateTime

  # The subject of the questionnaires
  resource_reference :subject, [Fhir::Patient, Fhir::RelatedPerson]

  # Person that collected the answers
  resource_reference :author, [Fhir::Practitioner, Fhir::Patient, Fhir::RelatedPerson]

  # The person that answered the questions
  resource_reference :source, [Fhir::Patient, Fhir::Practitioner, Fhir::RelatedPerson]

  # Name/code for a predefined list of questions
  attribute :name, Fhir::CodeableConcept

  # Identification of this questionnaire
  attribute :identifier, Fhir::Identifier

  # Primary encounter during which the answers were collected
  resource_reference :encounter, [Fhir::Encounter]

  # Answers to questions on a questionnaire.
  class Question < Fhir::ValueObject
    # Code or name of the question
    attribute :name, Fhir::CodeableConcept

    # Text of the question
    attribute :text, String

    # Single-valued answer to the question
    attribute :answer, *Fhir::Type[Float, Integer, Boolean, Date, String, DateTime, DateTime]

    # Selected options
    attribute :choices, Array[Fhir::Coding]

    # Valueset containing the possible options
    resource_reference :options, [Fhir::ValueSet]

    # Structured answer
    attribute :data, Object

    # Remarks about the answer given
    attribute :remarks, String
  end

  attribute :questions, Array[Question]

  # A group of questions to a possibly similarly grouped set
  # of question in the questionnaire.
  class Group < Fhir::ValueObject
    # Code or name of the section on a questionnaire
    attribute :name, Fhir::CodeableConcept

    # Header for the group
    attribute :header, String

    # Additional text for the group
    attribute :text, String

    # The subject this group's answers are about
    resource_reference :subject, [Fhir::Resource]

    # Questions belonging to this group
    attribute :questions, Array[Fhir::Questionnaire::Question]

    # Nested questionnaire group
    attribute :groups, Array[Fhir::Questionnaire::Group]
  end

  attribute :groups, Array[Group]
end

