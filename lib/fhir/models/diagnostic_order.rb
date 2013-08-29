# A request for a diagnostic service
class DiagnosticOrder
  include Virtus
  # Additional Content defined by implementations
  attribute :extension, Extension

  # Text summary of the resource, for human interpretation
  attribute :text, Narrative

  # Contained, inline Resources
  attribute :contained, Resource

  # Who/what test is about
  attribute :subject, Resource(Patient|Group|Location|Device)

  # Who ordered the test
  attribute :orderer, Resource(Practitioner)

  # Identifiers assigned to this order
  attribute :identifier, Identifier

  # The encounter that this diagnostic order is associated with
  attribute :encounter, Resource(Encounter)

  # Explanation/Justification for test
  attribute :clinicalNotes, String

  # If the whole order relates to specific specimens
  attribute :specimen, Resource(Specimen)

  # requested | received | accepted | inprogress | review | complete | suspended | rejected | failed
  attribute :status, code

  # normal | urgent | stat
  attribute :priority, code

  # A list of events of interest in the lifecycle
  attribute :event, Event

  class Event
    include Virtus::ValueObject
    # requested | received | accepted | inprogress | review | complete | suspended | rejected | failed
    attribute :status, code

    # The date at which the event happened
    attribute :date, DateTime

    # Who recorded or did this
    attribute :actor, Resource(Practitioner|Device)

  end
  # The items the orderer requested
  attribute :item, Item

  class Item
    include Virtus::ValueObject
    # Code for this item
    attribute :code, CodeableConcept

    # If this item relates to specific specimens
    attribute :specimen, Resource(Specimen)

    # Location of requested test (if applicable)
    attribute :bodySite, CodeableConcept

    # requested | received | accepted | inprogress | review | complete | suspended | rejected | failed
    attribute :status, code

    # Events specific to this item
    attribute :event, @DiagnosticOrder.event

  end
end
