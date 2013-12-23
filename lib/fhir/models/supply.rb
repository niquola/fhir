# A supply -  request and provision.
class Fhir::Supply < Fhir::Resource
  # Extensions that cannot be ignored
  attribute :modifier_extension, Array[Fhir::Extension]

  # Text summary of the resource, for human interpretation
  attribute :text, Fhir::Narrative

  # The kind of supply (central, non-stock, etc)
  attribute :name, Fhir::CodeableConcept

  # Unique identifier
  attribute :identifier, Fhir::Identifier

  # Dispensed|Received|Requested
  attribute :status, Fhir::Code

  # Medication, Substance, or Device requested to be supplied
  resource_reference :ordered_item, [Fhir::Medication, Fhir::Substance, Fhir::Device]

  # Patient
  resource_reference :patient, [Fhir::Patient]

  # Indicates the details of the dispense event such as the
  # days supply and quantity of a supply dispensed.
  class Dispense < Fhir::ValueObject
    # Extensions that cannot be ignored
    attribute :modifier_extension, Array[Fhir::Extension]

    # External identifier
    attribute :identifier, Fhir::Identifier

    # Active/Completed/Aborted
    attribute :status, Fhir::Code

    # Type of dispense
    attribute :type, Fhir::CodeableConcept

    # Amount dispensed
    attribute :quantity, Fhir::Quantity

    # Medication, Substance, or Device being supplied
    resource_reference :supplied_item, [Fhir::Medication, Fhir::Substance, Fhir::Device]

    # Dispenser
    resource_reference :supplier, [Fhir::Practitioner]

    # Dispensing time
    attribute :when_prepared, Fhir::Period

    # Handover time
    attribute :when_handed_over, Fhir::Period

    # Where the Supply was sent
    resource_reference :destination, [Fhir::Location]

    # Who collected the Supply
    resource_references :receiver, [Fhir::Practitioner]
  end

  attribute :dispense, Array[Dispense]
end


Fhir.load_extension('supply')
