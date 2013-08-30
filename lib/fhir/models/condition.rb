# Use to record detailed information about conditions,
# problems or diagnoses recognized by a clinician. There are
# many uses including: recording a Diagnosis during an
# Encounter; populating a problem List or a Summary Statement,
# such as a Discharge Summary.
class Fhir::Condition < Fhir::Resource
  # Additional Content defined by implementations
  attribute :extension, Array[Extension]

  # Text summary of the resource, for human interpretation
  attribute :text, Narrative

  # Contained, inline Resources
  attribute :contained, Array[ResourceLink[Resource]]

  # Subject of this condition
  # Should be present
  attribute :subject, ResourceLink[Patient]

  # Encounter during which the condition was first asserted
  attribute :encounter, ResourceLink[Encounter]

  # Person who asserts this condition
  attribute :asserter, ResourceLink[Practitioner, Patient]

  # When first detected/suspected/entered
  attribute :date_asserted, date

  # Identification of the condition, problem or diagnosis
  # Should be present
  attribute :code, CodeableConcept

  # E.g. complaint | symptom | finding | diagnosis
  attribute :category, CodeableConcept

  # provisional | working | confirmed | refuted
  # Should be present
  attribute :status, code

  # Degree of confidence
  attribute :certainty, CodeableConcept

  # Subjective severity of condition
  attribute :severity, CodeableConcept

  # Estimated or actual date, or age
  attribute :onset[x], date

  # If/when in resolution/remission
  attribute :abatement[x], date

  # Clinical stage or grade of a condition. May include formal
  # severity assessments.
  class Stage < Fhir::ValueObject
    # Simple summary (disease specific)
    attribute :summary, CodeableConcept

    # Formal record of assessment
    attribute :assessment, Array[ResourceLink[Any]]
  end

  attribute :stage, Stage

  # Supporting Evidence / manifestations that are the basis on
  # which this condition is suspected or confirmed.
  class Evidence < Fhir::ValueObject
    # Manifestation/symptom
    attribute :code, CodeableConcept

    # Supporting information found elsewhere
    attribute :detail, Array[ResourceLink[Any]]
  end

  attribute :evidence, Array[Evidence]

  # The anatomical location where this condition manifests
  # itself.
  class Location < Fhir::ValueObject
    # Location - may include laterality
    attribute :code, CodeableConcept

    # Precise location details
    attribute :detail, string
  end

  attribute :location, Array[Location]

  # Further conditions, problems, diagnoses, procedures or
  # events that are related in some way to this condition, or
  # the substance that caused/triggered this Condition.
  class RelatedItem < Fhir::ValueObject
    # due-to | follows
    # Should be present
    attribute :type, code

    # Relationship target by means of a predefined code
    attribute :code, CodeableConcept

    # Relationship target resource
    attribute :target, ResourceLink[Condition, Procedure, Substance]
  end

  attribute :related_item, Array[RelatedItem]

  # Additional information about the Condition
  attribute :notes, string
end

