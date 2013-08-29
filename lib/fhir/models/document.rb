class Document
  attribute :extension, Extension
  attribute :text, Narrative
  attribute :contained, Resource
  attribute :identifier, Identifier
  attribute :versionIdentifier, Identifier
  attribute :created, instant
  attribute :type, CodeableConcept
  attribute :subtype, CodeableConcept
  attribute :title, String
  attribute :status, code
  attribute :confidentiality, Coding
  attribute :subject, Resource(Patient|Practitioner|Group|Device)
  attribute :author, Resource(Practitioner|Device)
  attribute :attester, Attester
  class Attester
    attribute :mode, code
    attribute :time, DateTime
    attribute :party, Resource(Patient|Practitioner|Organization)
  end
  attribute :custodian, Resource(Organization)
  attribute :event, Event
  class Event
    attribute :code, CodeableConcept
    attribute :period, Period
    attribute :detail, Resource(Any)
  end
  attribute :encounter, Resource(Encounter|InterestOfCare)
  attribute :replaces, id
  attribute :provenance, Resource(Provenance)
  attribute :stylesheet, Attachment
  attribute :representation, Attachment
  attribute :section, Section
  class Section
    attribute :code, CodeableConcept
    attribute :subject, Resource(Patient|Group|Device)
    attribute :content, Resource(Any)
    attribute :section, @Document.section
  end
end
