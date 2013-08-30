# Describes the event of a patient being given a dose of a
# medication.  This may be as simple as swallowing a tablet or
# it may be a long running infusion.    Related resources tie
# this event to the authorizing prescription, and the specific
# encounter between patient and health care practitioner.
class Fhir::MedicationAdministration < Fhir::Resource
  # Additional Content defined by implementations
  attribute :extension, Array[Fhir::Extension] # Extension

  # Text summary of the resource, for human interpretation
  attribute :text, Fhir::Narrative # Narrative

  # Contained, inline Resources
  attribute :contained, Array[Fhir::Resource] # Resource

  # External Identifier
  attribute :identifier, Array[Fhir::Identifier] # Identifier

  # Status of the administration - active | paused | completed
  # | nullified
  # Should be present
  attribute :status, Fhir::Code # code

  # Patient
  # Should be present
  attribute :patient, Fhir::ResourceReference[Fhir::Patient] # Resource(Patient)

  # Practitioner (responsible Health Care professional)
  # Should be present
  attribute :practitioner, Fhir::ResourceReference[Fhir::Practitioner] # Resource(Practitioner)

  # Current Encounter / Admission
  attribute :encounter, Fhir::ResourceReference[Fhir::Encounter] # Resource(Encounter)

  # Prescription
  # Should be present
  attribute :prescription, Fhir::ResourceReference[Fhir::MedicationPrescription] # Resource(MedicationPrescription)

  # True if asserting medication was not given
  attribute :was_not_given, Boolean # boolean

  # Reason event is negated
  attribute :reason_not_given, Array[Fhir::CodeableConcept] # CodeableConcept

  # Effective time
  # Should be present
  attribute :when_given, Fhir::Period # Period

  # Medication
  attribute :medication, Fhir::ResourceReference[Fhir::Medication] # Resource(Medication)

  # Administration device
  attribute :administration_device, Array[Fhir::ResourceReference[Fhir::Device]] # Resource(Device)

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

  attribute :dosage, Array[Dosage] # 
end

