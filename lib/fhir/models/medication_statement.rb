class MedicationStatement
  attribute :extension, Extension
  attribute :text, Narrative
  attribute :contained, Resource
  attribute :identifier, Identifier
  attribute :patient, Resource(Patient)
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
