# Dispensing a medication to a named patient.  This includes
# a description of the supply provided and the instructions
# for administering the medication.
class Fhir::MedicationDispense < Fhir::Resource
  # Additional Content defined by implementations
  attribute :extension, Array[Extension]

  # Text summary of the resource, for human interpretation
  attribute :text, Narrative

  # Contained, inline Resources
  attribute :contained, Array[ResourceLink[Resource]]

  # External identifier
  attribute :identifier, Identifier

  # active | paused | completed | nullified
  attribute :status, code

  # Patient
  attribute :patient, ResourceLink[Patient]

  # Dispenser
  attribute :dispenser, ResourceLink[Practitioner]

  # Medication order that authorises the dispense
  attribute :authorizing_prescription, Array[ResourceLink[MedicationPrescription]]

  # Indicates the details of the dispense event such as the
  # days supply and quantity of medication dispensed.
  class Dispense < Fhir::ValueObject
    # External identifier
    attribute :identifier, Identifier

    # Active/Completed/Aborted
    attribute :status, code

    # Type of dispense
    attribute :type, CodeableConcept

    # Amount dispensed
    attribute :quantity, Quantity

    # Medication
    attribute :medication, ResourceLink[Medication]

    # Dispensing time
    attribute :when_prepared, Period

    # Handover time
    attribute :when_handed_over, Period

    # Where the medication was sent
    attribute :destination, ResourceLink[Location]

    # Who collected the medication
    attribute :receiver, Array[ResourceLink[Practitioner]]

    # Indicates how the medication is to be used by the patient.
    class Dosage < Fhir::ValueObject
      # Additional dosage instructions
      attribute :additional_instructions[x], string

      # Medication timing
      attribute :timing[x], dateTime

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

  attribute :dispense, Array[Dispense]

  # Indicates whether or not substitution was made as part of
  # the dispense.  In some cases substitution will be expected
  # but doesn't happen, in other cases substitution is not
  # expected but does happen.  This block explains what
  # substitition did or did not happen and why.
  class Substitution < Fhir::ValueObject
    # Type of substitiution
    # Should be present
    attribute :type, CodeableConcept

    # Why was substitution made
    attribute :reason, Array[CodeableConcept]

    # Who is responsible for the substitution
    attribute :responsible_party, Array[ResourceLink[Practitioner]]
  end

  attribute :substitution, Substitution
end

