# Simple assertions and measurements made about a patient,
# device or other subject.
class Fhir::Observation < Fhir::Resource
  invariants do
    validates_presence_of :name
    validates_presence_of :status
    validates_presence_of :reliability
  end

  # Extensions that cannot be ignored
  attribute :modifier_extension, Array[Fhir::Extension]

  # Text summary of the resource, for human interpretation
  attribute :text, Fhir::Narrative

  # Type of observation (code / type)
  attribute :name, Fhir::CodeableConcept

  # Actual result
  attribute :value, *Fhir::Type[Fhir::Quantity, Fhir::CodeableConcept, Fhir::Attachment, Fhir::Ratio, Fhir::Period, Fhir::SampledData, String]

  # High, low, normal, etc.
  attribute :interpretation, Fhir::CodeableConcept

  # Comments about result
  attribute :comments, String

  # Relevant time/time-period
  attribute :applies, *Fhir::Type[Fhir::Period, DateTime]

  # Date/Time this was made available
  attribute :issued, DateTime

  # registered | preliminary | final | amended +
  attribute :status, Fhir::Code

  # ok | ongoing | early | questionable | calibrating | error
  # +
  attribute :reliability, Fhir::Code

  # Observed body part
  attribute :body_site, Fhir::CodeableConcept

  # How it was done
  attribute :method_name, Fhir::CodeableConcept

  # Unique Id for this particular observation
  attribute :identifier, Fhir::Identifier

  # Who/what this is about
  resource_reference :subject, [Fhir::Patient, Fhir::Group, Fhir::Device, Fhir::Location]

  # Specimen used for this observation
  resource_reference :specimen, [Fhir::Specimen]

  # Who did the observation
  resource_references :performer, [Fhir::Practitioner, Fhir::Device, Fhir::Organization]

  # Guidance on how to interpret the value by comparison to a
  # normal or recommended range.
  class ReferenceRange < Fhir::ValueObject
    # Extensions that cannot be ignored
    attribute :modifier_extension, Array[Fhir::Extension]

    # Low Range, if relevant
    attribute :low, Fhir::Quantity

    # High Range, if relevant
    attribute :high, Fhir::Quantity

    # The meaning of this range
    attribute :meaning, Fhir::CodeableConcept

    # Applicable age range, if relevant
    attribute :age, Fhir::Period
  end

  attribute :reference_range, Array[ReferenceRange]
end


Fhir.load_extension('observation')
