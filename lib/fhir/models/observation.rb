# Simple observations
class Observation
  include Virtus
  # Additional Content defined by implementations
  attribute :extension, Extension

  # Text summary of the resource, for human interpretation
  attribute :text, Narrative

  # Contained, inline Resources
  attribute :contained, Resource

  # Kind of observation
  attribute :name, CodeableConcept

  # Actual result
  attribute :value[x], Quantity

  # High, low, normal, etc.
  attribute :interpretation, CodeableConcept

  # Comments about result
  attribute :comments, String

  # Relevant time/time-period
  attribute :applies[x], Period

  # Date/Time this was made available
  attribute :issued, instant

  # Registered|Interim|Final|Amended|Cancelled|Withdrawn
  attribute :status, code

  # If quality issues exist (mostly devices)
  attribute :reliability, code

  # Observed body part
  attribute :bodySite, CodeableConcept

  # How it was done
  attribute :method, CodeableConcept

  # Observation id
  attribute :identifier, Identifier

  # Who/what this is about
  attribute :subject, Resource(Patient|Group|Device)

  # Who did the observation
  attribute :performer, Resource(Practitioner|Device|Organization)

  # Provides guide for interpretation
  attribute :referenceRange, ReferenceRange

  class ReferenceRange
    include Virtus::ValueObject
    # The meaning of this range
    attribute :meaning, CodeableConcept

    # Reference
    attribute :range[x], Quantity

  end
  # Component observation
  attribute :component, Component

  class Component
    include Virtus::ValueObject
    # Kind of component observation
    attribute :name, CodeableConcept

    # Actual component result
    attribute :value[x], Quantity

  end
end
