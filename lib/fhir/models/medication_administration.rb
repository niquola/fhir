class MedicationAdministration
  attribute :extension, Extension
  attribute :text, Narrative
  attribute :contained, Resource
  attribute :identifier, Identifier
  attribute :status, code
  attribute :patient, Resource(Patient)
  attribute :practitioner, Resource(Practitioner)
  attribute :encounter, Resource(Encounter)
  attribute :prescription, Resource(MedicationPrescription)
  attribute :wasNotGiven, boolean
  attribute :reasonNotGiven, CodeableConcept
  attribute :whenGiven, Period
  attribute :medication, Resource(Medication)
  attribute :administrationDevice, Resource(Device)
  attribute :dosage, Dosage
  class Dosage
    attribute :timing, Schedule
    attribute :site, CodeableConcept
    attribute :route, CodeableConcept
    attribute :method, CodeableConcept
    attribute :quantity, Quantity
    attribute :rate, Ratio
    attribute :maxDosePerPeriod, Ratio
  end
end
