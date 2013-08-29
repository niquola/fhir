# Prescription of medication to for patient
class MedicationPrescription
  include Virtus
  # Additional Content defined by implementations
  attribute :extension, Extension

  # Text summary of the resource, for human interpretation
  attribute :text, Narrative

  # Contained, inline Resources
  attribute :contained, Resource

  # External identifier
  attribute :identifier, Identifier

  # Prescription date
  attribute :dateWritten, DateTime

  # active | paused | completed | nullified
  attribute :status, code

  # Patient
  attribute :patient, Resource(Patient)

  # Prescriber
  attribute :prescriber, Resource(Practitioner)

  # Encounter / Admission / Stay
  attribute :encounter, Resource(Encounter)

  # Reason or indication for writing the prescription
  attribute :reasonForPrescribing[x], String

  # Medication to be taken
  attribute :medication, Resource(Medication)

  # Dosage instructions
  attribute :dosageInstruction, DosageInstruction

  class DosageInstruction
    include Virtus::ValueObject
    # Dosage text
    attribute :dosageInstructionsText, String

    # Additional dosage instructions
    attribute :additionalInstructions[x], String

    # Medication timing
    attribute :timing[x], DateTime

    # Entry site
    attribute :site, CodeableConcept

    # Route of administration
    attribute :route, CodeableConcept

    # Administration method
    attribute :method, CodeableConcept

    # Dose quantity per dose
    attribute :doseQuantity, Quantity

    # Dose quantity per unit of time
    attribute :rate, Ratio

    # Total dose that should be consumed per unit of time
    attribute :maxDosePerPeriod, Ratio

  end
  # Dispense request
  attribute :dispense, Dispense

  class Dispense
    include Virtus::ValueObject
    # Medication to be dispensed
    attribute :medication, Resource(Medication)

    # Validity period
    attribute :validityPeriod, Period

    # Number of repeats allowed
    attribute :numberOfRepeatsAllowed, integer

    # Quanity
    attribute :quantity, Quantity

    # Expected supply duration
    attribute :expectedSupplyDuration, Duration

  end
  # Deals with substitution of one medicine for another
  attribute :substitution, Substitution

  class Substitution
    include Virtus::ValueObject
    # Type of substitiution
    attribute :type, CodeableConcept

    # Why should substitution (not) be made
    attribute :reason, CodeableConcept

  end
end
