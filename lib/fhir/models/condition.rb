# Use to record detailed information about conditions,
# problems or diagnoses recognized by a clinician. There are
# many uses including: recording a Diagnosis during an
# Encounter; populating a problem List or a Summary Statement,
# such as a Discharge Summary.
class Fhir::Condition < Fhir::Resource
  invariants do
    validates_presence_of :subject_ref
    validates_presence_of :code
    validates_presence_of :status
  end

  # Extensions that cannot be ignored
  attribute :modifier_extension, Array[Fhir::Extension]

  # Text summary of the resource, for human interpretation
  attribute :text, Fhir::Narrative

  # External Ids for this condition
  attribute :identifier, Array[Fhir::Identifier]

  # Subject of this condition
  resource_reference :subject, [Fhir::Patient]

  # Encounter when condition first asserted
  resource_reference :encounter, [Fhir::Encounter]

  # Person who asserts this condition
  resource_reference :asserter, [Fhir::Practitioner, Fhir::Patient]

  # When first detected/suspected/entered
  attribute :date_asserted, Date

  # Identification of the condition, problem or diagnosis
  attribute :code, Fhir::CodeableConcept

  # E.g. complaint | symptom | finding | diagnosis
  attribute :category, Fhir::CodeableConcept

  # provisional | working | confirmed | refuted
  attribute :status, Fhir::Code

  # Degree of confidence
  attribute :certainty, Fhir::CodeableConcept

  # Subjective severity of condition
  attribute :severity, Fhir::CodeableConcept

  # Estimated or actual date, or age
  attribute :onset, *Fhir::Type[Date, Fhir::Quantity]

  # If/when in resolution/remission
  attribute :abatement, *Fhir::Type[Date, Fhir::Quantity, Boolean]

  # Clinical stage or grade of a condition. May include formal
  # severity assessments.
  class Stage < Fhir::ValueObject
    # Extensions that cannot be ignored
    attribute :modifier_extension, Array[Fhir::Extension]

    # Simple summary (disease specific)
    attribute :summary, Fhir::CodeableConcept

    # Formal record of assessment
    resource_references :assessment, [Fhir::Resource]
  end

  attribute :stage, Stage

  # Supporting Evidence / manifestations that are the basis on
  # which this condition is suspected or confirmed.
  class Evidence < Fhir::ValueObject
    # Extensions that cannot be ignored
    attribute :modifier_extension, Array[Fhir::Extension]

    # Manifestation/symptom
    attribute :code, Fhir::CodeableConcept

    # Supporting information found elsewhere
    resource_references :detail, [Fhir::Resource]
  end

  attribute :evidence, Array[Evidence]

  # The anatomical location where this condition manifests
  # itself.
  class Location < Fhir::ValueObject
    # Extensions that cannot be ignored
    attribute :modifier_extension, Array[Fhir::Extension]

    # Location - may include laterality
    attribute :code, Fhir::CodeableConcept

    # Precise location details
    attribute :detail, String
  end

  attribute :location, Array[Location]

  # Further conditions, problems, diagnoses, procedures or
  # events that are related in some way to this condition, or
  # the substance that caused/triggered this Condition.
  class RelatedItem < Fhir::ValueObject
    invariants do
      validates_presence_of :type
    end

    # Extensions that cannot be ignored
    attribute :modifier_extension, Array[Fhir::Extension]

    # due-to | following
    attribute :type, Fhir::Code

    # Relationship target by means of a predefined code
    attribute :code, Fhir::CodeableConcept

    # Relationship target resource
    resource_reference :target, [Fhir::Condition, Fhir::Procedure, Fhir::MedicationAdministration, Fhir::Immunization, Fhir::MedicationStatement]
  end

  attribute :related_item, Array[RelatedItem]

  # Additional information about the Condition
  attribute :notes, String
end


Fhir.load_extension('condition')
