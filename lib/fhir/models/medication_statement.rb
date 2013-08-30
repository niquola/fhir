# A record of medication being taken by a patient, or that
# the medication has been given to a patient where the record
# is the result of a report from the patient, or another
# clinician.
class Fhir::MedicationStatement < Fhir::Resource
  # Additional Content defined by implementations
  attribute :extension, Array[Extension]

  # Text summary of the resource, for human interpretation
  attribute :text, Narrative

  # Contained, inline Resources
  attribute :contained, Array[ResourceLink[Resource]]

  # External Identifier
  attribute :identifier, Array[Identifier]

  # Patient
  attribute :patient, ResourceLink[Patient]

  # True if asserting medication was not given
  attribute :was_not_given, boolean

  # True if asserting medication was not given
  attribute :reason_not_given, Array[CodeableConcept]

  # Effective time
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

