# Simple assertions and measurements made about a patient,
# device or other subject.
class Fhir::Observation < Fhir::Resource
  # Additional Content defined by implementations
  attribute :extension, Array[Extension]

  # Text summary of the resource, for human interpretation
  attribute :text, Narrative

  # Contained, inline Resources
  attribute :contained, Array[ResourceLink[Resource]]

  # Kind of observation
  # Should be present
  attribute :name, CodeableConcept

  # Actual result
  attribute :value[x], Quantity

  # High, low, normal, etc.
  attribute :interpretation, CodeableConcept

  # Comments about result
  attribute :comments, string

  # Relevant time/time-period
  attribute :applies[x], Period

  # Date/Time this was made available
  attribute :issued, instant

  # Registered|Interim|Final|Amended|Cancelled|Withdrawn
  # Should be present
  attribute :status, code

  # If quality issues exist (mostly devices)
  # Should be present
  attribute :reliability, code

  # Observed body part
  attribute :body_site, CodeableConcept

  # How it was done
  attribute :method, CodeableConcept

  # Observation id
  attribute :identifier, Identifier

  # Who/what this is about
  attribute :subject, ResourceLink[Patient, Group, Device]

  # Who did the observation
  attribute :performer, ResourceLink[Practitioner, Device, Organization]

  # Guidance on how to interpret the value by comparison to a
  # normal or recommended range.
  class ReferenceRange < Fhir::ValueObject
    # The meaning of this range
    attribute :meaning, CodeableConcept

    # Reference
    # Should be present
    attribute :range[x], Quantity
  end

  attribute :reference_range, Array[ReferenceRange]

  # Component observation.
  class Component < Fhir::ValueObject
    # Kind of component observation
    # Should be present
    attribute :name, CodeableConcept

    # Actual component result
    # Should be present
    attribute :value[x], Quantity
  end

  attribute :component, Array[Component]
end

