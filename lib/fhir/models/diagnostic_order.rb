class DiagnosticOrder
  attribute :extension, Extension
  attribute :text, Narrative
  attribute :contained, Resource
  attribute :subject, Resource(Patient|Group|Location|Device)
  attribute :orderer, Resource(Practitioner)
  attribute :identifier, Identifier
  attribute :encounter, Resource(Encounter)
  attribute :clinicalNotes, String
  attribute :specimen, Resource(Specimen)
  attribute :status, code
  attribute :priority, code
  attribute :event, Event
  class Event
    attribute :status, code
    attribute :date, DateTime
    attribute :actor, Resource(Practitioner|Device)
  end
  attribute :item, Item
  class Item
    attribute :code, CodeableConcept
    attribute :specimen, Resource(Specimen)
    attribute :bodySite, CodeableConcept
    attribute :status, code
    attribute :event, @DiagnosticOrder.event
  end
end
