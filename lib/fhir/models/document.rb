# A documentation of healthcare-related information that is
# assembled together into a single statement of meaning that
# establishes its own context. A document is composed of a set
# of resources that include both human and computer readable
# portions. A human may attest to the accuracy of the human
# readable portion and may authenticate and/or sign the entire
# whole. A document may be kept as a set of logically linked
# resources, or they may be bundled together in an atom feed.
class Fhir::Document < Fhir::Resource
  invariants do
    validates_presence_of :created
    validates_presence_of :type
    validates_presence_of :status
    validates_presence_of :confidentiality
    validates_presence_of :subject_ref
    validates_presence_of :author_refs
  end

  # Text summary of the resource, for human interpretation
  attribute :text, Fhir::Narrative

  # Logical identifier for document (version-independent)
  attribute :identifier, Fhir::Identifier

  # Version-specific identifier for document
  attribute :version_identifier, Fhir::Identifier

  # Document creation time
  attribute :created, DateTime

  # Kind of document (LOINC if possible)
  attribute :type, Fhir::CodeableConcept

  # More detail about the document type
  attribute :subtype, Fhir::CodeableConcept

  # Document title
  attribute :title, String

  # Status of this document
  attribute :status, Fhir::Code

  # As defined by affinity domain
  attribute :confidentiality, Fhir::Coding

  # Who/what the document is about
  resource_reference :subject, [Fhir::Patient, Fhir::Practitioner, Fhir::Group, Fhir::Device]

  # Who/what authored the final document
  resource_references :authors, [Fhir::Practitioner, Fhir::Device]

  # A participant who has attested to the accuracy of the
  # document.
  class Attester < Fhir::ValueObject
    invariants do
      validates_presence_of :mode
    end

    # personal | professional | legal | official
    attribute :mode, Fhir::Code

    # When document attested
    attribute :time, DateTime

    # Who attested the document
    resource_reference :party, [Fhir::Patient, Fhir::Practitioner, Fhir::Organization]
  end

  attribute :attesters, Array[Attester]

  # Org which maintains the document
  resource_reference :custodian, [Fhir::Organization]

  # The main event/act/item, such as a colonoscopy or an
  # appendectomy, being documented.
  class Event < Fhir::ValueObject
    # Code(s) that apply to the event being documented
    attribute :codes, Array[Fhir::CodeableConcept]

    # The period covered by the document
    attribute :period, Fhir::Period

    # Full details for the event(s) the document concents
    resource_references :details, [Fhir::Resource]
  end

  attribute :event, Event

  # Context of the document
  resource_reference :encounter, [Fhir::Encounter]

  # If this document replaces another
  attribute :replaces, String

  # Additional provenance about the document and its parts
  resource_references :provenances, [Fhir::Provenance]

  # Stylesheet to use when rendering the document
  attribute :stylesheet, Fhir::Attachment

  # Alternative representation of the document
  attribute :representation, Fhir::Attachment

  # Identifies a main topic within the document's table of
  # contents.
  class Section < Fhir::ValueObject
    # Classification of section (recommended)
    attribute :code, Fhir::CodeableConcept

    # If section different to document
    resource_reference :subject, [Fhir::Patient, Fhir::Group, Fhir::Device]

    # The actual data for the section
    resource_reference :content, [Fhir::Resource]

    # Nested Section
    attribute :sections, Array[Fhir::Document::Section]
  end

  attribute :sections, Array[Section]
end


Fhir.load_handmade('models/document')
