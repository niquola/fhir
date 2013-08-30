# Describes the event of a patient being given a dose of a
# medication.  This may be as simple as swallowing a tablet or
# it may be a long running infusion.    Related resources tie
# this event to the authorizing prescription, and the specific
# encounter between patient and health care practitioner.
class Fhir::MedicationAdministration < Fhir::Resource
  # Additional Content defined by implementations
  attribute :extension, Array[Extension]

  # Text summary of the resource, for human interpretation
  attribute :text, Narrative

  # Contained, inline Resources
  attribute :contained, Array[ResourceLink[Resource]]

  # External Identifier
  attribute :identifier, Array[Identifier]

  # Status of the administration - active | paused | completed
  # | nullified
  # Should be present
  attribute :status, code

  # Patient
  # Should be present
  attribute :patient, ResourceLink[Patient]

  # Practitioner (responsible Health Care professional)
  # Should be present
  attribute :practitioner, ResourceLink[Practitioner]

  # Current Encounter / Admission
  attribute :encounter, ResourceLink[Encounter]

  # Prescription
  # Should be present
  attribute :prescription, ResourceLink[MedicationPrescription]

  # True if asserting medication was not given
  attribute :was_not_given, boolean

  # Reason event is negated
  attribute :reason_not_given, Array[CodeableConcept]

  # Effective time
  # Should be present
  attribute :when_given, Period

  # Medication
  attribute :medication, ResourceLink[Medication]

  # Administration device
  attribute :administration_device, Array[ResourceLink[Device]]

  # Indicates how the medication is to be used by the patient.
  class Dosage < Fhir::ValueObject
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
    attribute :max_dose_per_period, Ratio
  end

  attribute :dosage, Array[Dosage]
end

