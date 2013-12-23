# A structured set of questions and their answers. The
# Questionnaire may contain questions, answers or both. The
# questions may be ordered and grouped into coherent subsets,
# corresponding to the structure of the grouping of the
# underlying questions.
class Fhir::Questionnaire < Fhir::Resource
  invariants do
    validates_presence_of :status
    validates_presence_of :authored
  end

  # Extensions that cannot be ignored
  attribute :modifier_extension, Array[Fhir::Extension]

  # Text summary of the resource, for human interpretation
  attribute :text, Fhir::Narrative

  # draft | published | retired | in progress | completed |
  # amended
  attribute :status, Fhir::Code

  # Date this version was authored
  attribute :authored, DateTime

  # The subject of the questions
  resource_reference :subject, [Fhir::Patient, Fhir::RelatedPerson]

  # Person who received and recorded the answers
  resource_reference :author, [Fhir::Practitioner, Fhir::Patient, Fhir::RelatedPerson]

  # The person who answered the questions
  resource_reference :source, [Fhir::Patient, Fhir::Practitioner, Fhir::RelatedPerson]

  # Name/code for a predefined list of questions
  attribute :name, Fhir::CodeableConcept

  # External Ids for this questionnaire
  attribute :identifier, Array[Fhir::Identifier]

  # Primary encounter during which the answers were collected
  resource_reference :encounter, [Fhir::Encounter]

  # A group of questions to a possibly similarly grouped set
  # of question in the questionnaire.
  class Group < Fhir::ValueObject
    # Extensions that cannot be ignored
    attribute :modifier_extension, Array[Fhir::Extension]

    # Code or name of the section on a questionnaire
    attribute :name, Fhir::CodeableConcept

    # Text that is displayed above the contents of the group
    attribute :header, String

    # Additional text for the group
    attribute :text, String

    # Whether the contents of this group have a meaningful order
    attribute :ordered, Boolean

    # The subject this group's answers are about
    resource_reference :subject, [Fhir::Resource]

    # Nested questionnaire group
    attribute :group, Array[Fhir::Questionnaire::Group]

    # Set of questions within this group.
    class Question < Fhir::ValueObject
      # Extensions that cannot be ignored
      attribute :modifier_extension, Array[Fhir::Extension]

      # Code or name of the question
      attribute :name, Fhir::CodeableConcept

      # Text of the question as it is shown to the user
      attribute :text, String

      # Single-valued answer to the question
      attribute :answer, *Fhir::Type[Float, Integer, Boolean, Date, String, DateTime, DateTime]

      # Selected options
      attribute :choice, Array[Fhir::Coding]

      # Valueset containing the possible options
      resource_reference :options, [Fhir::ValueSet]

      # Structured answer
      attribute :data, Object

      # Remarks about the answer given
      attribute :remarks, String

      # Nested questionnaire group
      attribute :group, Array[Fhir::Questionnaire::Group]
    end

    attribute :question, Array[Question]
  end

  attribute :group, Group
end


Fhir.load_extension('questionnaire')
