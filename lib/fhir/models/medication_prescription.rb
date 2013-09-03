# An order for both supply of the medication and the
# instructions for administration of the medicine to a
# patient.
class Fhir::MedicationPrescription < Fhir::Resource
  # External identifier
  attribute :identifiers, Array[Fhir::Identifier] # Identifier

  # Prescription date
  attribute :date_written, DateTime # dateTime

  # active | paused | completed | nullified
  attribute :status, Fhir::Code # code

  # Patient
  resource_reference :patient, [Fhir::Patient]

  # Prescriber
  resource_reference :prescriber, [Fhir::Practitioner]

  # Encounter / Admission / Stay
  resource_reference :encounter, [Fhir::Encounter]

  # Reason or indication for writing the prescription
  attribute :reason_for_prescribing, String # string

  # Medication to be taken
  resource_reference :medication, [Fhir::Medication]

  # Indicates how the medication is to be used by the patient.
  class DosageInstruction < Fhir::ValueObject
    # Dosage text
    attribute :dosage_instructions_text, String # string

    # Additional dosage instructions
    attribute :additional_instructions, String # string

    # Medication timing
    attribute :timing, DateTime # dateTime

    # Entry site
    attribute :site, Fhir::CodeableConcept # CodeableConcept

    # Route of administration
    attribute :route, Fhir::CodeableConcept # CodeableConcept

    # Administration method
    attribute :method, Fhir::CodeableConcept # CodeableConcept

    # Dose quantity per dose
    attribute :dose_quantity, Fhir::Quantity # Quantity

    # Dose quantity per unit of time
    attribute :rate, Fhir::Ratio # Ratio

    # Total dose that should be consumed per unit of time
    attribute :max_dose_per_period, Fhir::Ratio # Ratio
  end

  attribute :dosage_instructions, Array[DosageInstruction] # 

  # Deals with details of the dispense part of the order.
  class Dispense < Fhir::ValueObject
    # Medication to be dispensed
    resource_reference :medication, [Fhir::Medication]

    # Validity period
    attribute :validity_period, Fhir::Period # Period

    # Number of repeats allowed
    attribute :number_of_repeats_allowed, Integer # integer

    # Quanity
    attribute :quantity, Fhir::Quantity # Quantity

    # Expected supply duration
    attribute :expected_supply_duration, Fhir::Quantity # Duration
  end

  attribute :dispense, Dispense # 

  # Indicates whether or not substitution can or should as
  # part of the dispense.  In some cases substitution must 
  # happen, in other cases substitution must not happen, and in
  # others it does not matter.  This block explains the
  # prescribers intent.  If nothing is specified substitution
  # may be done.
  class Substitution < Fhir::ValueObject
    # Type of substitiution
    # Should be present
    attribute :type, Fhir::CodeableConcept # CodeableConcept

    # Why should substitution (not) be made
    attribute :reason, Fhir::CodeableConcept # CodeableConcept
  end

  attribute :substitution, Substitution # 
end

