# A documentation of healthcare-related information that is
# assembled together into a single statement of meaning that
# establishes its own context. A document is composed of a set
# of resources that include both human and computer readable
# portions. A human may attest to the accuracy of the human
# readable portion and may authenticate and/or sign the entire
# whole. A document may be kept as a set of logically linked
# resources, or they may be bundled together in an atom feed.
class Fhir::Document < Fhir::Resource
  # Additional Content defined by implementations
  attribute :extension, Array[Extension]

  # Text summary of the resource, for human interpretation
  attribute :text, Narrative

  # Contained, inline Resources
  attribute :contained, Array[ResourceLink[Resource]]

  # Logical identifier for document (version-independent)
  attribute :identifier, Identifier

  # Version-specific identifier for document
  attribute :version_identifier, Identifier

  # Document creation time
  # Should be present
  attribute :created, instant

  # Kind of document (LOINC if possible)
  # Should be present
  attribute :type, CodeableConcept

  # More detail about the document type
  attribute :subtype, CodeableConcept

  # Document title
  attribute :title, string

  # Status of this document
  # Should be present
  attribute :status, code

  # As defined by affinity domain
  # Should be present
  attribute :confidentiality, Coding

  # Who/what the document is about
  # Should be present
  attribute :subject, ResourceLink[Patient, Practitioner, Group, Device]

  # Who/what authored the final document
  # Should be present
  attribute :author, Array[ResourceLink[Practitioner, Device]]

  # A participant who has attested to the accuracy of the
  # document.
  class Attester < Fhir::ValueObject
    # personal | professional | legal | official
    # Should be present
    attribute :mode, code

    # When document attested
    attribute :time, dateTime

    # Who attested the document
    attribute :party, ResourceLink[Patient, Practitioner, Organization]
  end

  attribute :attester, Array[Attester]

  # Org which maintains the document
  attribute :custodian, ResourceLink[Organization]

  # The main event/act/item, such as a colonoscopy or an
  # appendectomy, being documented.
  class Event < Fhir::ValueObject
    # Code(s) that apply to the event being documented
    attribute :code, Array[CodeableConcept]

    # The period covered by the document
    attribute :period, Period

    # Full details for the event(s) the document concents
    attribute :detail, Array[ResourceLink[Any]]
  end

  attribute :event, Event

  # Context of the document
  attribute :encounter, ResourceLink[Encounter, InterestOfCare]

  # If this document replaces another
  attribute :replaces, id

  # Additional provenance about the document and its parts
  attribute :provenance, Array[ResourceLink[Provenance]]

  # Stylesheet to use when rendering the document
  attribute :stylesheet, Attachment

  # Alternative representation of the document
  attribute :representation, Attachment

  # Identifies a main topic within the document's table of
  # contents.
  class Section < Fhir::ValueObject
    # Classification of section (recommended)
    attribute :code, CodeableConcept

    # If section different to document
    attribute :subject, ResourceLink[Patient, Group, Device]

    # The actual data for the section
    attribute :content, ResourceLink[Any]

    # Nested Section
    attribute :section, Array[@Document.section]
  end

  attribute :section, Array[Section]
end

