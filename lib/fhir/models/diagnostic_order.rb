# A request for a diagnostic investigation service to be
# performed.
class Fhir::DiagnosticOrder < Fhir::Resource
  # Additional Content defined by implementations
  attribute :extension, Array[Extension]

  # Text summary of the resource, for human interpretation
  attribute :text, Narrative

  # Contained, inline Resources
  attribute :contained, Array[ResourceLink[Resource]]

  # Who/what test is about
  # Should be present
  attribute :subject, ResourceLink[Patient, Group, Location, Device]

  # Who ordered the test
  attribute :orderer, ResourceLink[Practitioner]

  # Identifiers assigned to this order
  attribute :identifier, Array[Identifier]

  # The encounter that this diagnostic order is associated
  # with
  attribute :encounter, ResourceLink[Encounter]

  # Explanation/Justification for test
  attribute :clinical_notes, string

  # If the whole order relates to specific specimens
  attribute :specimen, Array[ResourceLink[Specimen]]

  # requested | received | accepted | inprogress | review |
  # complete | suspended | rejected | failed
  attribute :status, code

  # normal | urgent | stat
  attribute :priority, code

  # A summary of the events of interest that have occurred as
  # the request is processed.
  class Event < Fhir::ValueObject
    # requested | received | accepted | inprogress | review |
    # complete | suspended | rejected | failed
    # Should be present
    attribute :status, code

    # The date at which the event happened
    # Should be present
    attribute :date, dateTime

    # Who recorded or did this
    attribute :actor, ResourceLink[Practitioner, Device]
  end

  attribute :event, Array[Event]

  # The specific diagnostic investigations that are requested
  # as part of this request. Sometimes, there can only be one
  # item per request, but in most contexts, more than one
  # investigation can be requested.
  class Item < Fhir::ValueObject
    # Code for this item
    # Should be present
    attribute :code, CodeableConcept

    # If this item relates to specific specimens
    attribute :specimen, Array[ResourceLink[Specimen]]

    # Location of requested test (if applicable)
    attribute :body_site, CodeableConcept

    # requested | received | accepted | inprogress | review |
    # complete | suspended | rejected | failed
    attribute :status, code

    # Events specific to this item
    attribute :event, Array[@DiagnosticOrder.event]
  end

  attribute :item, Array[Item]
end

