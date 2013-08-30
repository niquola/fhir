# A supply -  request and provision.
class Fhir::Supply < Fhir::Resource
  # Additional Content defined by implementations
  attribute :extension, Array[Extension]

  # Text summary of the resource, for human interpretation
  attribute :text, Narrative

  # Contained, inline Resources
  attribute :contained, Array[ResourceLink[Resource]]

  # The kind of supply (central, non-stock, etc)
  attribute :name, CodeableConcept

  # Unique identifier
  attribute :identifier, Identifier

  # Dispensed|Received|Requested
  attribute :status, code

  # Medication, Substance, or Device requested to be supplied
  attribute :ordered_item, ResourceLink[Medication, Substance, Device]

  # Patient
  attribute :patient, ResourceLink[Patient]

  # Indicates the details of the dispense event such as the
  # days supply and quantity of a supply dispensed.
  class Dispense < Fhir::ValueObject
    # External identifier
    attribute :identifier, Identifier

    # Active/Completed/Aborted
    attribute :status, code

    # Type of dispense
    attribute :type, CodeableConcept

    # Amount dispensed
    attribute :quantity, Quantity

    # Medication, Substance, or Device being supplied
    attribute :supplied_item, ResourceLink[Medication, Substance, Device]

    # Dispenser
    attribute :supplier, ResourceLink[Practitioner]

    # Dispensing time
    attribute :when_prepared, Period

    # Handover time
    attribute :when_handed_over, Period

    # Where the Supply was sent
    attribute :destination, ResourceLink[Location]

    # Who collected the Supply
    attribute :receiver, Array[ResourceLink[Practitioner]]
  end

  attribute :dispense, Array[Dispense]
end

