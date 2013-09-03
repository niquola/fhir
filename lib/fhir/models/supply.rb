# A supply -  request and provision.
class Fhir::Supply < Fhir::Resource
  # The kind of supply (central, non-stock, etc)
  attribute :name, Fhir::CodeableConcept # CodeableConcept

  # Unique identifier
  attribute :identifier, Fhir::Identifier # Identifier

  # Dispensed|Received|Requested
  attribute :status, Fhir::Code # code

  # Medication, Substance, or Device requested to be supplied
  resource_reference :ordered_item, [Fhir::Medication, Fhir::Substance, Fhir::Device]

  # Patient
  resource_reference :patient, [Fhir::Patient]

  # Indicates the details of the dispense event such as the
  # days supply and quantity of a supply dispensed.
  class Dispense < Fhir::ValueObject
    # External identifier
    attribute :identifier, Fhir::Identifier # Identifier

    # Active/Completed/Aborted
    attribute :status, Fhir::Code # code

    # Type of dispense
    attribute :type, Fhir::CodeableConcept # CodeableConcept

    # Amount dispensed
    attribute :quantity, Fhir::Quantity # Quantity

    # Medication, Substance, or Device being supplied
    resource_reference :supplied_item, [Fhir::Medication, Fhir::Substance, Fhir::Device]

    # Dispenser
    resource_reference :supplier, [Fhir::Practitioner]

    # Dispensing time
    attribute :when_prepared, Fhir::Period # Period

    # Handover time
    attribute :when_handed_over, Fhir::Period # Period

    # Where the Supply was sent
    resource_reference :destination, [Fhir::Location]

    # Who collected the Supply
    resource_references :receivers, [Fhir::Practitioner]
  end

  attribute :dispenses, Array[Dispense] # 
end

