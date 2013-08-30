# Simple assertions and measurements made about a patient,
# device or other subject.
class Fhir::Observation < Fhir::Resource
  # Additional Content defined by implementations
  attribute :extension, Array[Fhir::Extension] # Extension

  # Text summary of the resource, for human interpretation
  attribute :text, Fhir::Narrative # Narrative

  # Contained, inline Resources
  attribute :contained, Array[Fhir::Resource] # Resource

  # Kind of observation
  # Should be present
  attribute :name, Fhir::CodeableConcept # CodeableConcept

  # Actual result
  attribute :value, Fhir::Quantity # Quantity

  # High, low, normal, etc.
  attribute :interpretation, Fhir::CodeableConcept # CodeableConcept

  # Comments about result
  attribute :comments, String # string

  # Relevant time/time-period
  attribute :applies, Fhir::Period # Period

  # Date/Time this was made available
  attribute :issued, DateTime # instant

  # Registered|Interim|Final|Amended|Cancelled|Withdrawn
  # Should be present
  attribute :status, Fhir::Code # code

  # If quality issues exist (mostly devices)
  # Should be present
  attribute :reliability, Fhir::Code # code

  # Observed body part
  attribute :body_site, Fhir::CodeableConcept # CodeableConcept

  # How it was done
  attribute :method, Fhir::CodeableConcept # CodeableConcept

  # Observation id
  attribute :identifier, Fhir::Identifier # Identifier

  # Who/what this is about
  attribute :subject, Fhir::ResourceReference[Fhir::Patient, Fhir::Group, Fhir::Device] # Resource(Patient|Group|Device)

  # Who did the observation
  attribute :performer, Fhir::ResourceReference[Fhir::Practitioner, Fhir::Device, Fhir::Organization] # Resource(Practitioner|Device|Organization)

  # Guidance on how to interpret the value by comparison to a
  # normal or recommended range.
  class ReferenceRange < Fhir::ValueObject
    # The meaning of this range
    attribute :meaning, Fhir::CodeableConcept # CodeableConcept

    # Reference
    # Should be present
    attribute :range, Fhir::Quantity # Quantity
  end

  attribute :reference_range, Array[ReferenceRange] # 

  # Component observation.
  class Component < Fhir::ValueObject
    # Kind of component observation
    # Should be present
    attribute :name, Fhir::CodeableConcept # CodeableConcept

    # Actual component result
    # Should be present
    attribute :value, Fhir::Quantity # Quantity
  end

  attribute :component, Array[Component] # 
end

