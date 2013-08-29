class Supply
  attribute :extension, Extension
  attribute :text, Narrative
  attribute :contained, Resource
  attribute :name, CodeableConcept
  attribute :identifier, Identifier
  attribute :status, code
  attribute :orderedItem, Resource(Medication|Substance|Device)
  attribute :patient, Resource(Patient)
  attribute :dispense, Dispense
  class Dispense
    attribute :identifier, Identifier
    attribute :status, code
    attribute :type, CodeableConcept
    attribute :quantity, Quantity
    attribute :suppliedItem, Resource(Medication|Substance|Device)
    attribute :supplier, Resource(Practitioner)
    attribute :whenPrepared, Period
    attribute :whenHandedOver, Period
    attribute :destination, Resource(Location)
    attribute :receiver, Resource(Practitioner)
  end
end
