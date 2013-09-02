# A record of medication being taken by a patient, or that
# the medication has been given to a patient where the record
# is the result of a report from the patient, or another
# clinician.
class Fhir::MedicationStatement < Fhir::Resource
  # Additional Content defined by implementations
  attribute :extensions, Array[Fhir::Extension] # Extension

  # Text summary of the resource, for human interpretation
  attribute :text, Fhir::Narrative # Narrative

  # Contained, inline Resources
  attribute :containeds, Array[Fhir::Resource] # Resource

  # External Identifier
  attribute :identifiers, Array[Fhir::Identifier] # Identifier

  # Patient
  attribute :patient, Fhir::ResourceReference[Fhir::Patient] # Resource(Patient)

  # True if asserting medication was not given
  attribute :was_not_given, Boolean # boolean

  # True if asserting medication was not given
  attribute :reason_not_givens, Array[Fhir::CodeableConcept] # CodeableConcept

  # Effective time
  attribute :when_given, Fhir::Period # Period

  # Medication
  attribute :medication, Fhir::ResourceReference[Fhir::Medication] # Resource(Medication)

  # Administration device
  attribute :administration_devices, Array[Fhir::ResourceReference[Fhir::Device]] # Resource(Device)

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

