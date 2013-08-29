class Document
  include Virtus
  # Additional Content defined by implementations
  attribute :extension, Extension

  # Text summary of the resource, for human interpretation
  attribute :text, Narrative

  # Contained, inline Resources
  attribute :contained, Resource

  # Logical identifier for document (version-independent)
  attribute :identifier, Identifier

  # Version-specific identifier for document
  attribute :versionIdentifier, Identifier

  # Document creation time
  attribute :created, instant

  # Kind of document (LOINC if possible)
  attribute :type, CodeableConcept

  # More detail about the document type
  attribute :subtype, CodeableConcept

  # Document title
  attribute :title, String

  # Status of this document
  attribute :status, code

  # As defined by affinity domain
  attribute :confidentiality, Coding

  # Who/what the document is about
  attribute :subject, Resource(Patient|Practitioner|Group|Device)

  # Who/what authored the final document
  attribute :author, Resource(Practitioner|Device)

  # Attests to accuracy of document
  attribute :attester, Attester

  class Attester
    include Virtus::ValueObject
    # personal | professional | legal | official
    attribute :mode, code

    # When document attested
    attribute :time, DateTime

    # Who attested the document
    attribute :party, Resource(Patient|Practitioner|Organization)

  end
  # Org which maintains the document
  attribute :custodian, Resource(Organization)

  # The clinical event/act/item being documented
  attribute :event, Event

  class Event
    include Virtus::ValueObject
    # Code(s) that apply to the event being documented
    attribute :code, CodeableConcept

    # The period covered by the document
    attribute :period, Period

    # Full details for the event(s) the document concents
    attribute :detail, Resource(Any)

  end
  # Context of the document
  attribute :encounter, Resource(Encounter|InterestOfCare)

  # If this document replaces another
  attribute :replaces, id

  # Additional provenance about the document and its parts
  attribute :provenance, Resource(Provenance)

  # Stylesheet to use when rendering the document
  attribute :stylesheet, Attachment

  # Alternative representation of the document
  attribute :representation, Attachment

  # Document is broken into sections
  attribute :section, Section

  class Section
    include Virtus::ValueObject
    # Classification of section (recommended)
    attribute :code, CodeableConcept

    # If section different to document
    attribute :subject, Resource(Patient|Group|Device)

    # The actual data for the section
    attribute :content, Resource(Any)

    # Nested Section
    attribute :section, @Document.section

  end
end
