# A supply -  request and provision.
class Fhir::Supply < Fhir::Resource
  # Additional Content defined by implementations
  attribute :extension, Array[Fhir::Extension] # Extension

  # Text summary of the resource, for human interpretation
  attribute :text, Fhir::Narrative # Narrative

  # Contained, inline Resources
  attribute :contained, Array[Fhir::Resource] # Resource

  # The kind of supply (central, non-stock, etc)
  attribute :name, Fhir::CodeableConcept # CodeableConcept

  # Unique identifier
  attribute :identifier, Fhir::Identifier # Identifier

  # Dispensed|Received|Requested
  attribute :status, Fhir::Code # code

  # Medication, Substance, or Device requested to be supplied
  attribute :ordered_item, Fhir::ResourceReference[Fhir::Medication, Fhir::Substance, Fhir::Device] # Resource(Medication|Substance|Device)

  # Patient
  attribute :patient, Fhir::ResourceReference[Fhir::Patient] # Resource(Patient)

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
    attribute :supplied_item, Fhir::ResourceReference[Fhir::Medication, Fhir::Substance, Fhir::Device] # Resource(Medication|Substance|Device)

    # Dispenser
    attribute :supplier, Fhir::ResourceReference[Fhir::Practitioner] # Resource(Practitioner)

    # Dispensing time
    attribute :when_prepared, Fhir::Period # Period

    # Handover time
    attribute :when_handed_over, Fhir::Period # Period

    # Where the Supply was sent
    attribute :destination, Fhir::ResourceReference[Fhir::Location] # Resource(Location)

    # Who collected the Supply
    attribute :receiver, Array[Fhir::ResourceReference[Fhir::Practitioner]] # Resource(Practitioner)
  end

  attribute :dispense, Array[Dispense] # 
end

