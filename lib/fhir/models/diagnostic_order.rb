# A request for a diagnostic investigation service to be
# performed.
class Fhir::DiagnosticOrder < Fhir::Resource
  # Additional Content defined by implementations
  attribute :extension, Array[Fhir::Extension] # Extension

  # Text summary of the resource, for human interpretation
  attribute :text, Fhir::Narrative # Narrative

  # Contained, inline Resources
  attribute :contained, Array[Fhir::Resource] # Resource

  # Who/what test is about
  # Should be present
  attribute :subject, Fhir::ResourceReference[Fhir::Patient, Fhir::Group, Fhir::Location, Fhir::Device] # Resource(Patient|Group|Location|Device)

  # Who ordered the test
  attribute :orderer, Fhir::ResourceReference[Fhir::Practitioner] # Resource(Practitioner)

  # Identifiers assigned to this order
  attribute :identifier, Array[Fhir::Identifier] # Identifier

  # The encounter that this diagnostic order is associated
  # with
  attribute :encounter, Fhir::ResourceReference[Fhir::Encounter] # Resource(Encounter)

  # Explanation/Justification for test
  attribute :clinical_notes, String # string

  # If the whole order relates to specific specimens
  attribute :specimen, Array[Fhir::ResourceReference[Fhir::Specimen]] # Resource(Specimen)

  # requested | received | accepted | inprogress | review |
  # complete | suspended | rejected | failed
  attribute :status, Fhir::Code # code

  # normal | urgent | stat
  attribute :priority, Fhir::Code # code

  # A summary of the events of interest that have occurred as
  # the request is processed.
  class Event < Fhir::ValueObject
    # requested | received | accepted | inprogress | review |
    # complete | suspended | rejected | failed
    # Should be present
    attribute :status, Fhir::Code # code

    # The date at which the event happened
    # Should be present
    attribute :date, DateTime # dateTime

    # Who recorded or did this
    attribute :actor, Fhir::ResourceReference[Fhir::Practitioner, Fhir::Device] # Resource(Practitioner|Device)
  end

  attribute :event, Array[Event] # 

  # The specific diagnostic investigations that are requested
  # as part of this request. Sometimes, there can only be one
  # item per request, but in most contexts, more than one
  # investigation can be requested.
  class Item < Fhir::ValueObject
    # Code for this item
    # Should be present
    attribute :code, Fhir::CodeableConcept # CodeableConcept

    # If this item relates to specific specimens
    attribute :specimen, Array[Fhir::ResourceReference[Fhir::Specimen]] # Resource(Specimen)

    # Location of requested test (if applicable)
    attribute :body_site, Fhir::CodeableConcept # CodeableConcept

    # requested | received | accepted | inprogress | review |
    # complete | suspended | rejected | failed
    attribute :status, Fhir::Code # code

    # Events specific to this item
    attribute :event, Array[Fhir::DiagnosticOrder::Event] # @DiagnosticOrder.event
  end

  attribute :item, Array[Item] # 
end

