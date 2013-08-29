class MedicationPrescription
  attribute :extension, Extension
  attribute :text, Narrative
  attribute :contained, Resource
  attribute :identifier, Identifier
  attribute :dateWritten, DateTime
  attribute :status, code
  attribute :patient, Resource(Patient)
  attribute :prescriber, Resource(Practitioner)
  attribute :encounter, Resource(Encounter)
  attribute :reasonForPrescribing[x], String
  attribute :medication, Resource(Medication)
  attribute :dosageInstruction, DosageInstruction
  class DosageInstruction
    attribute :dosageInstructionsText, String
    attribute :additionalInstructions[x], String
    attribute :timing[x], DateTime
    attribute :site, CodeableConcept
    attribute :route, CodeableConcept
    attribute :method, CodeableConcept
    attribute :doseQuantity, Quantity
    attribute :rate, Ratio
    attribute :maxDosePerPeriod, Ratio
  end
  attribute :dispense, Dispense
  class Dispense
    attribute :medication, Resource(Medication)
    attribute :validityPeriod, Period
    attribute :numberOfRepeatsAllowed, integer
    attribute :quantity, Quantity
    attribute :expectedSupplyDuration, Duration
  end
  attribute :substitution, Substitution
  class Substitution
    attribute :type, CodeableConcept
    attribute :reason, CodeableConcept
  end
end
