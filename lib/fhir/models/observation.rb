# Simple assertions and measurements made about a patient,
# device or other subject.
class Fhir::Observation < Fhir::Resource
  invariants do
    validates_presence_of :name
    validates_presence_of :status
    validates_presence_of :reliability
  end

  # Text summary of the resource, for human interpretation
  attribute :text, Fhir::Narrative

  # Kind of observation
  attribute :name, Fhir::CodeableConcept

  # Actual result
  attribute :value, *Fhir::Type[Fhir::Quantity, Fhir::CodeableConcept, Fhir::Attachment, Fhir::Ratio, Fhir::Choice, Fhir::Period, Fhir::SampledData, String]

  # High, low, normal, etc.
  attribute :interpretation, Fhir::CodeableConcept

  # Comments about result
  attribute :comments, String

  # Relevant time/time-period
  attribute :applies, *Fhir::Type[Fhir::Period, DateTime]

  # Date/Time this was made available
  attribute :issued, DateTime

  # Registered|Interim|Final|Amended|Cancelled|Withdrawn
  attribute :status, Fhir::Code

  # If quality issues exist (mostly devices)
  attribute :reliability, Fhir::Code

  # Observed body part
  attribute :body_site, Fhir::CodeableConcept

  # How it was done
  attribute :method_name, Fhir::CodeableConcept

  # Observation id
  attribute :identifier, Fhir::Identifier

  # Who/what this is about
  resource_reference :subject, [Fhir::Patient, Fhir::Group, Fhir::Device]

  # Who did the observation
  resource_reference :performer, [Fhir::Practitioner, Fhir::Device, Fhir::Organization]

  # Guidance on how to interpret the value by comparison to a
  # normal or recommended range.
  class ReferenceRange < Fhir::ValueObject
    invariants do
      validates_presence_of :range
    end

    # The meaning of this range
    attribute :meaning, Fhir::CodeableConcept

    # Reference
    attribute :range, *Fhir::Type[Fhir::Quantity, Fhir::Range, String]
  end

  attribute :reference_ranges, Array[ReferenceRange]

  # Component observation.
  class Component < Fhir::ValueObject
    invariants do
      validates_presence_of :name
      validates_presence_of :value
    end

    # Kind of component observation
    attribute :name, Fhir::CodeableConcept

    # Actual component result
    attribute :value, *Fhir::Type[Fhir::Quantity, Fhir::CodeableConcept, Fhir::Attachment, Fhir::Ratio, Fhir::Choice, Fhir::Period, Fhir::SampledData, String]
  end

  attribute :components, Array[Component]
end


Fhir.load_extension('observation')
