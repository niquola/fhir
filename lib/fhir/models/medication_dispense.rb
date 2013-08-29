class MedicationDispense
  include Virtus
  # Additional Content defined by implementations
  attribute :extension, Extension

  # Text summary of the resource, for human interpretation
  attribute :text, Narrative

  # Contained, inline Resources
  attribute :contained, Resource

  # External identifier
  attribute :identifier, Identifier

  # active | paused | completed | nullified
  attribute :status, code

  # Patient
  attribute :patient, Resource(Patient)

  # Dispenser
  attribute :dispenser, Resource(Practitioner)

  # Medication order that authorises the dispense
  attribute :authorizingPrescription, Resource(MedicationPrescription)

  # Medicine supply details
  attribute :dispense, Dispense

  class Dispense
    include Virtus::ValueObject
    # External identifier
    attribute :identifier, Identifier

    # Active/Completed/Aborted
    attribute :status, code

    # Type of dispense
    attribute :type, CodeableConcept

    # Amount dispensed
    attribute :quantity, Quantity

    # Medication
    attribute :medication, Resource(Medication)

    # Dispensing time
    attribute :whenPrepared, Period

    # Handover time
    attribute :whenHandedOver, Period

    # Where the medication was sent
    attribute :destination, Resource(Location)

    # Who collected the medication
    attribute :receiver, Resource(Practitioner)

    # Medicine administration instructions to the patient/carer
    attribute :dosage, Dosage

    class Dosage
      include Virtus::ValueObject
      # Additional dosage instructions
      attribute :additionalInstructions[x], String

      # Medication timing
      attribute :timing[x], DateTime

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
      attribute :maxDosePerPeriod, Ratio

    end
  end
  # Deals with substitution of one medicine for another
  attribute :substitution, Substitution

  class Substitution
    include Virtus::ValueObject
    # Type of substitiution
    attribute :type, CodeableConcept

    # Why was substitution made
    attribute :reason, CodeableConcept

    # Who is responsible for the substitution
    attribute :responsibleParty, Resource(Practitioner)

  end
end
