class MedicationDispense
  attribute :extension, Extension
  attribute :text, Narrative
  attribute :contained, Resource
  attribute :identifier, Identifier
  attribute :status, code
  attribute :patient, Resource(Patient)
  attribute :dispenser, Resource(Practitioner)
  attribute :authorizingPrescription, Resource(MedicationPrescription)
  attribute :dispense, Dispense
  class Dispense
    attribute :identifier, Identifier
    attribute :status, code
    attribute :type, CodeableConcept
    attribute :quantity, Quantity
    attribute :medication, Resource(Medication)
    attribute :whenPrepared, Period
    attribute :whenHandedOver, Period
    attribute :destination, Resource(Location)
    attribute :receiver, Resource(Practitioner)
    attribute :dosage, Dosage
    class Dosage
      attribute :additionalInstructions[x], String
      attribute :timing[x], DateTime
      attribute :site, CodeableConcept
      attribute :route, CodeableConcept
      attribute :method, CodeableConcept
      attribute :quantity, Quantity
      attribute :rate, Ratio
      attribute :maxDosePerPeriod, Ratio
    end
  end
  attribute :substitution, Substitution
  class Substitution
    attribute :type, CodeableConcept
    attribute :reason, CodeableConcept
    attribute :responsibleParty, Resource(Practitioner)
  end
end
