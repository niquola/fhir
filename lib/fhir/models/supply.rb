# A supply -  request and provision
class Supply
  include Virtus
  # Additional Content defined by implementations
  attribute :extension, Extension

  # Text summary of the resource, for human interpretation
  attribute :text, Narrative

  # Contained, inline Resources
  attribute :contained, Resource

  # The kind of supply (central, non-stock, etc)
  attribute :name, CodeableConcept

  # Unique identifier
  attribute :identifier, Identifier

  # Dispensed|Received|Requested
  attribute :status, code

  # Medication, Substance, or Device requested to be supplied
  attribute :orderedItem, Resource(Medication|Substance|Device)

  # Patient
  attribute :patient, Resource(Patient)

  # Supply details
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

    # Medication, Substance, or Device being supplied
    attribute :suppliedItem, Resource(Medication|Substance|Device)

    # Dispenser
    attribute :supplier, Resource(Practitioner)

    # Dispensing time
    attribute :whenPrepared, Period

    # Handover time
    attribute :whenHandedOver, Period

    # Where the Supply was sent
    attribute :destination, Resource(Location)

    # Who collected the Supply
    attribute :receiver, Resource(Practitioner)

  end
end
