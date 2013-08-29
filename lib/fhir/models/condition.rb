class Condition
  include Virtus
  # Additional Content defined by implementations
  attribute :extension, Extension

  # Text summary of the resource, for human interpretation
  attribute :text, Narrative

  # Contained, inline Resources
  attribute :contained, Resource

  # Subject of this condition
  attribute :subject, Resource(Patient)

  # Encounter during which the condition was first asserted
  attribute :encounter, Resource(Encounter)

  # Person who asserts this condition
  attribute :asserter, Resource(Practitioner|Patient)

  # When first detected/suspected/entered
  attribute :dateAsserted, date

  # Identification of the condition, problem or diagnosis
  attribute :code, CodeableConcept

  # E.g. complaint | symptom | finding | diagnosis
  attribute :category, CodeableConcept

  # provisional | working | confirmed | refuted
  attribute :status, code

  # Degree of confidence
  attribute :certainty, CodeableConcept

  # Subjective severity of condition
  attribute :severity, CodeableConcept

  # Estimated or actual date, or age
  attribute :onset[x], date

  # If/when in resolution/remission
  attribute :abatement[x], date

  # Stage/grade, usually assessed formally
  attribute :stage, Stage

  class Stage
    include Virtus::ValueObject
    # Simple summary (disease specific)
    attribute :summary, CodeableConcept

    # Formal record of assessment
    attribute :assessment, Resource(Any)

  end
  # Supporting evidence
  attribute :evidence, Evidence

  class Evidence
    include Virtus::ValueObject
    # Manifestation/symptom
    attribute :code, CodeableConcept

    # Supporting information found elsewhere
    attribute :detail, Resource(Any)

  end
  # Anatomical location, if relevant
  attribute :location, Location

  class Location
    include Virtus::ValueObject
    # Location - may include laterality
    attribute :code, CodeableConcept

    # Precise location details
    attribute :detail, String

  end
  # Causes or precedents for this Condition
  attribute :relatedItem, RelatedItem

  class RelatedItem
    include Virtus::ValueObject
    # due-to | follows
    attribute :type, code

    # Relationship target by means of a predefined code
    attribute :code, CodeableConcept

    # Relationship target resource
    attribute :target, Resource(Condition|Procedure|Substance)

  end
  # Additional information about the Condition
  attribute :notes, String

end
