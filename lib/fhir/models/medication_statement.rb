class MedicationStatement
  include Virtus
  # Additional Content defined by implementations
  attribute :extension, Extension

  # Text summary of the resource, for human interpretation
  attribute :text, Narrative

  # Contained, inline Resources
  attribute :contained, Resource

  # External Identifier
  attribute :identifier, Identifier

  # Patient
  attribute :patient, Resource(Patient)

  # True if asserting medication was not given
  attribute :wasNotGiven, boolean

  # True if asserting medication was not given
  attribute :reasonNotGiven, CodeableConcept

  # Effective time
  attribute :whenGiven, Period

  # Medication
  attribute :medication, Resource(Medication)

  # Administration device
  attribute :administrationDevice, Resource(Device)

  # Medicine administration instructions to the patient/carer
  attribute :dosage, Dosage

  class Dosage
    include Virtus::ValueObject
    # Medication timing
    attribute :timing, Schedule

    # Entry site
    attribute :site, CodeableConcept

    # Rout of administration
    attribute :route, CodeableConcept

    # Administration method
    attribute :method, CodeableConcept

    # Dose quantity per dose
    attribute :quantity, Quantity

    # Dose quantity per unit of time
    attribute :rate, Ratio

    # Total dose that should be consumed per unit of time
    attribute :maxDosePerPeriod, Ratio

  end
end
