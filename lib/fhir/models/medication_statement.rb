# A record of medication being taken by a patient, or that
# the medication has been given to a patient where the record
# is the result of a report from the patient, or another
# clinician.
class Fhir::MedicationStatement < Fhir::Resource
  # Text summary of the resource, for human interpretation
  attribute :text, Fhir::Narrative

  # External Identifier
  attribute :identifiers, Array[Fhir::Identifier]

  # Patient
  resource_reference :patient, [Fhir::Patient]

  # True if asserting medication was not given
  attribute :was_not_given, Boolean

  # True if asserting medication was not given
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
    attribute :method, Fhir::CodeableConcept

    # Dose quantity per dose
    attribute :quantity, Fhir::Quantity

    # Dose quantity per unit of time
    attribute :rate, Fhir::Ratio

    # Total dose that should be consumed per unit of time
    attribute :max_dose_per_period, Fhir::Ratio
  end

  attribute :dosages, Array[Dosage]
end


Fhir.load_handmade('medication_statement')
