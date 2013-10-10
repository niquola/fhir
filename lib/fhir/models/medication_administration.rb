# Describes the event of a patient being given a dose of a
# medication.  This may be as simple as swallowing a tablet or
# it may be a long running infusion.    Related resources tie
# this event to the authorizing prescription, and the specific
# encounter between patient and health care practitioner.
class Fhir::MedicationAdministration < Fhir::Resource
  invariants do
    validates_presence_of :status
    validates_presence_of :patient_ref
    validates_presence_of :practitioner_ref
    validates_presence_of :prescription_ref
    validates_presence_of :when_given
  end

  # Text summary of the resource, for human interpretation
  attribute :text, Fhir::Narrative

  # External Identifier
  attribute :identifiers, Array[Fhir::Identifier]

  # Status of the administration - active | paused | completed
  # | nullified
  attribute :status, Fhir::Code

  # Patient
  resource_reference :patient, [Fhir::Patient]

  # Practitioner (responsible Health Care professional)
  resource_reference :practitioner, [Fhir::Practitioner]

  # Current Encounter / Admission
  resource_reference :encounter, [Fhir::Encounter]

  # Prescription
  resource_reference :prescription, [Fhir::MedicationPrescription]

  # True if asserting medication was not given
  attribute :was_not_given, Boolean

  # Reason event is negated
  attribute :reason_not_givens, Array[Fhir::CodeableConcept]

  # Effective time
  attribute :when_given, Fhir::Period

  # Medication
  resource_reference :medication, [Fhir::Medication]

  # Administration device
  resource_references :administration_devices, [Fhir::Device]

  # Indicates how the medication is to be used by the patient.
  class Dosage < Fhir::ValueObject
    # Medication timing
    attribute :timing, Fhir::Schedule

    # Entry site
    attribute :site, Fhir::CodeableConcept

    # Rout of administration
    attribute :route, Fhir::CodeableConcept

    # Administration method
    attribute :method_name, Fhir::CodeableConcept

    # Dose quantity per dose
    attribute :quantity, Fhir::Quantity

    # Dose quantity per unit of time
    attribute :rate, Fhir::Ratio

    # Total dose that should be consumed per unit of time
    attribute :max_dose_per_period, Fhir::Ratio
  end

  attribute :dosages, Array[Dosage]
end


Fhir.load_extension('medication_administration')
