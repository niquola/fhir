# A request for a diagnostic investigation service to be
# performed.
class Fhir::DiagnosticOrder < Fhir::Resource
  invariants do
    validates_presence_of :subject
  end

  # Who/what test is about
  # Should be present
  resource_reference :subject, [Fhir::Patient, Fhir::Group, Fhir::Location, Fhir::Device]

  # Who ordered the test
  resource_reference :orderer, [Fhir::Practitioner]

  # Identifiers assigned to this order
  attribute :identifiers, Array[Fhir::Identifier]

  # The encounter that this diagnostic order is associated
  # with
  resource_reference :encounter, [Fhir::Encounter]

  # Explanation/Justification for test
  attribute :clinical_notes, String

  # If the whole order relates to specific specimens
  resource_references :specimen, [Fhir::Specimen]

  # requested | received | accepted | inprogress | review |
  # complete | suspended | rejected | failed
  attribute :status, Fhir::Code

  # normal | urgent | stat
  attribute :priority, Fhir::Code

  # A summary of the events of interest that have occurred as
  # the request is processed.
  class Event < Fhir::ValueObject
    invariants do
      validates_presence_of :status
      validates_presence_of :date
    end

    # requested | received | accepted | inprogress | review |
    # complete | suspended | rejected | failed
    # Should be present
    attribute :status, Fhir::Code

    # The date at which the event happened
    # Should be present
    attribute :date, DateTime

    # Who recorded or did this
    resource_reference :actor, [Fhir::Practitioner, Fhir::Device]
  end

  attribute :events, Array[Event]

  # The specific diagnostic investigations that are requested
  # as part of this request. Sometimes, there can only be one
  # item per request, but in most contexts, more than one
  # investigation can be requested.
  class Item < Fhir::ValueObject
    invariants do
      validates_presence_of :code
    end

    # Code for this item
    # Should be present
    attribute :code, Fhir::CodeableConcept

    # If this item relates to specific specimens
    resource_references :specimen, [Fhir::Specimen]

    # Location of requested test (if applicable)
    attribute :body_site, Fhir::CodeableConcept

    # requested | received | accepted | inprogress | review |
    # complete | suspended | rejected | failed
    attribute :status, Fhir::Code

    # Events specific to this item
    attribute :events, Array[Fhir::DiagnosticOrder::Event]
  end

  attribute :items, Array[Item]
end

