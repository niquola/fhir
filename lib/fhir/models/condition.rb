# Use to record detailed information about conditions,
# problems or diagnoses recognized by a clinician. There are
# many uses including: recording a Diagnosis during an
# Encounter; populating a problem List or a Summary Statement,
# such as a Discharge Summary.
class Fhir::Condition < Fhir::Resource
  # Subject of this condition
  # Should be present
  resource_reference :subject, [Fhir::Patient]

  # Encounter during which the condition was first asserted
  resource_reference :encounter, [Fhir::Encounter]

  # Person who asserts this condition
  resource_reference :asserter, [Fhir::Practitioner, Fhir::Patient]

  # When first detected/suspected/entered
  attribute :date_asserted, Date # date

  # Identification of the condition, problem or diagnosis
  # Should be present
  attribute :code, Fhir::CodeableConcept # CodeableConcept

  # E.g. complaint | symptom | finding | diagnosis
  attribute :category, Fhir::CodeableConcept # CodeableConcept

  # provisional | working | confirmed | refuted
  # Should be present
  attribute :status, Fhir::Code # code

  # Degree of confidence
  attribute :certainty, Fhir::CodeableConcept # CodeableConcept

  # Subjective severity of condition
  attribute :severity, Fhir::CodeableConcept # CodeableConcept

  # Estimated or actual date, or age
  attribute :onset, Date # date

  # If/when in resolution/remission
  attribute :abatement, Date # date

  # Clinical stage or grade of a condition. May include formal
  # severity assessments.
  class Stage < Fhir::ValueObject
    # Simple summary (disease specific)
    attribute :summary, Fhir::CodeableConcept # CodeableConcept

    # Formal record of assessment
    resource_references :assessments, [Fhir::Resource]
  end

  attribute :stage, Stage # 

  # Supporting Evidence / manifestations that are the basis on
  # which this condition is suspected or confirmed.
  class Evidence < Fhir::ValueObject
    # Manifestation/symptom
    attribute :code, Fhir::CodeableConcept # CodeableConcept

    # Supporting information found elsewhere
    resource_references :details, [Fhir::Resource]
  end

  attribute :evidences, Array[Evidence] # 

  # The anatomical location where this condition manifests
  # itself.
  class Location < Fhir::ValueObject
    # Location - may include laterality
    attribute :code, Fhir::CodeableConcept # CodeableConcept

    # Precise location details
    attribute :detail, String # string
  end

  attribute :locations, Array[Location] # 

  # Further conditions, problems, diagnoses, procedures or
  # events that are related in some way to this condition, or
  # the substance that caused/triggered this Condition.
  class RelatedItem < Fhir::ValueObject
    # due-to | follows
    # Should be present
    attribute :type, Fhir::Code # code

    # Relationship target by means of a predefined code
    attribute :code, Fhir::CodeableConcept # CodeableConcept

    # Relationship target resource
    resource_reference :target, [Fhir::Condition, Fhir::Procedure, Fhir::Substance]
  end

  attribute :related_items, Array[RelatedItem] # 

  # Additional information about the Condition
  attribute :notes, String # string
end

