# An order for both supply of the medication and the
# instructions for administration of the medicine to a
# patient.
class Fhir::MedicationPrescription < Fhir::Resource
  # Additional Content defined by implementations
  attribute :extension, Array[Extension]

  # Text summary of the resource, for human interpretation
  attribute :text, Narrative

  # Contained, inline Resources
  attribute :contained, Array[ResourceLink[Resource]]

  # External identifier
  attribute :identifier, Array[Identifier]

  # Prescription date
  attribute :date_written, dateTime

  # active | paused | completed | nullified
  attribute :status, code

  # Patient
  attribute :patient, ResourceLink[Patient]

  # Prescriber
  attribute :prescriber, ResourceLink[Practitioner]

  # Encounter / Admission / Stay
  attribute :encounter, ResourceLink[Encounter]

  # Reason or indication for writing the prescription
  attribute :reason_for_prescribing[x], string

  # Medication to be taken
  attribute :medication, ResourceLink[Medication]

  # Indicates how the medication is to be used by the patient.
  class DosageInstruction < Fhir::ValueObject
    # Dosage text
    attribute :dosage_instructions_text, string

    # Additional dosage instructions
    attribute :additional_instructions[x], string

    # Medication timing
    attribute :timing[x], dateTime

    # Entry site
    attribute :site, CodeableConcept

    # Route of administration
    attribute :route, CodeableConcept

    # Administration method
    attribute :method, CodeableConcept

    # Dose quantity per dose
    attribute :dose_quantity, Quantity

    # Dose quantity per unit of time
    attribute :rate, Ratio

    # Total dose that should be consumed per unit of time
    attribute :max_dose_per_period, Ratio
  end

  attribute :dosage_instruction, Array[DosageInstruction]

  # Deals with details of the dispense part of the order.
  class Dispense < Fhir::ValueObject
    # Medication to be dispensed
    attribute :medication, ResourceLink[Medication]

    # Validity period
    attribute :validity_period, Period

    # Number of repeats allowed
    attribute :number_of_repeats_allowed, integer

    # Quanity
    attribute :quantity, Quantity

    # Expected supply duration
    attribute :expected_supply_duration, Duration
  end

  attribute :dispense, Dispense

  # Indicates whether or not substitution can or should as
  # part of the dispense.  In some cases substitution must 
  # happen, in other cases substitution must not happen, and in
  # others it does not matter.  This block explains the
  # prescribers intent.  If nothing is specified substitution
  # may be done.
  class Substitution < Fhir::ValueObject
    # Type of substitiution
    # Should be present
    attribute :type, CodeableConcept

    # Why should substitution (not) be made
    attribute :reason, CodeableConcept
  end

  attribute :substitution, Substitution
end

