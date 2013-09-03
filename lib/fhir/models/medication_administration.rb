# Describes the event of a patient being given a dose of a
# medication.  This may be as simple as swallowing a tablet or
# it may be a long running infusion.    Related resources tie
# this event to the authorizing prescription, and the specific
# encounter between patient and health care practitioner.
class Fhir::MedicationAdministration < Fhir::Resource
  # External Identifier
  attribute :identifiers, Array[Fhir::Identifier] # Identifier

  # Status of the administration - active | paused | completed
  # | nullified
  # Should be present
  attribute :status, Fhir::Code # code

  # Patient
  # Should be present
  resource_reference :patient, [Fhir::Patient]

  # Practitioner (responsible Health Care professional)
  # Should be present
  resource_reference :practitioner, [Fhir::Practitioner]

  # Current Encounter / Admission
  resource_reference :encounter, [Fhir::Encounter]

  # Prescription
  # Should be present
  resource_reference :prescription, [Fhir::MedicationPrescription]

  # True if asserting medication was not given
  attribute :was_not_given, Boolean # boolean

  # Reason event is negated
  attribute :reason_not_givens, Array[Fhir::CodeableConcept] # CodeableConcept

  # Effective time
  # Should be present
  attribute :when_given, Fhir::Period # Period

  # Medication
  resource_reference :medication, [Fhir::Medication]

  # Administration device
  resource_references :administration_devices, [Fhir::Device]

  # Indicates how the medication is to be used by the patient.
  class Dosage < Fhir::ValueObject
    # Medication timing
    attribute :timing, Fhir::Schedule # Schedule

    # Entry site
    attribute :site, Fhir::CodeableConcept # CodeableConcept

    # Rout of administration
    attribute :route, Fhir::CodeableConcept # CodeableConcept

    # Administration method
    attribute :method, Fhir::CodeableConcept # CodeableConcept

    # Dose quantity per dose
    attribute :quantity, Fhir::Quantity # Quantity

    # Dose quantity per unit of time
    attribute :rate, Fhir::Ratio # Ratio

    # Total dose that should be consumed per unit of time
    attribute :max_dose_per_period, Fhir::Ratio # Ratio
  end

  attribute :dosages, Array[Dosage] # 
end

