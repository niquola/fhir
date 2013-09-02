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
  attribute :extensions, Array[Fhir::Extension] # Extension

  # Text summary of the resource, for human interpretation
  attribute :text, Fhir::Narrative # Narrative

  # Contained, inline Resources
  attribute :containeds, Array[Fhir::Resource] # Resource

  # Logical identifier for document (version-independent)
  attribute :identifier, Fhir::Identifier # Identifier

  # Version-specific identifier for document
  attribute :version_identifier, Fhir::Identifier # Identifier

  # Document creation time
  # Should be present
  attribute :created, DateTime # instant

  # Kind of document (LOINC if possible)
  # Should be present
  attribute :type, Fhir::CodeableConcept # CodeableConcept

  # More detail about the document type
  attribute :subtype, Fhir::CodeableConcept # CodeableConcept

  # Document title
  attribute :title, String # string

  # Status of this document
  # Should be present
  attribute :status, Fhir::Code # code

  # As defined by affinity domain
  # Should be present
  attribute :confidentiality, Fhir::Coding # Coding

  # Who/what the document is about
  # Should be present
  attribute :subject, Fhir::ResourceReference[Fhir::Patient, Fhir::Practitioner, Fhir::Group, Fhir::Device] # Resource(Patient|Practitioner|Group|Device)

  # Who/what authored the final document
  # Should be present
  attribute :authors, Array[Fhir::ResourceReference[Fhir::Practitioner, Fhir::Device]] # Resource(Practitioner|Device)

  # A participant who has attested to the accuracy of the
  # document.
  class Attester < Fhir::ValueObject
    # personal | professional | legal | official
    # Should be present
    attribute :mode, Fhir::Code # code

    # When document attested
    attribute :time, DateTime # dateTime

    # Who attested the document
    attribute :party, Fhir::ResourceReference[Fhir::Patient, Fhir::Practitioner, Fhir::Organization] # Resource(Patient|Practitioner|Organization)
  end

  attribute :attesters, Array[Attester] # 

  # Org which maintains the document
  attribute :custodian, Fhir::ResourceReference[Fhir::Organization] # Resource(Organization)

  # The main event/act/item, such as a colonoscopy or an
  # appendectomy, being documented.
  class Event < Fhir::ValueObject
    # Code(s) that apply to the event being documented
    attribute :codes, Array[Fhir::CodeableConcept] # CodeableConcept

    # The period covered by the document
    attribute :period, Fhir::Period # Period

    # Full details for the event(s) the document concents
    attribute :details, Array[Fhir::ResourceReference] # Resource(Any)
  end

  attribute :event, Event # 

  # Context of the document
  attribute :encounter, Fhir::ResourceReference[Fhir::Encounter] # Resource(Encounter|InterestOfCare)

  # If this document replaces another
  attribute :replaces, String # id

  # Additional provenance about the document and its parts
  attribute :provenances, Array[Fhir::ResourceReference[Fhir::Provenance]] # Resource(Provenance)

  # Stylesheet to use when rendering the document
  attribute :stylesheet, Fhir::Attachment # Attachment

  # Alternative representation of the document
  attribute :representation, Fhir::Attachment # Attachment

  # Identifies a main topic within the document's table of
  # contents.
  class Section < Fhir::ValueObject
    # Classification of section (recommended)
    attribute :code, Fhir::CodeableConcept # CodeableConcept

    # If section different to document
    attribute :subject, Fhir::ResourceReference[Fhir::Patient, Fhir::Group, Fhir::Device] # Resource(Patient|Group|Device)

    # The actual data for the section
    attribute :content, Fhir::ResourceReference # Resource(Any)

    # Nested Section
    attribute :sections, Array[Fhir::Document::Section] # @Document.section
  end

  attribute :sections, Array[Section] # 
end

