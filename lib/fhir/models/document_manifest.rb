# A manifest that defines a set of documents.
class Fhir::DocumentManifest < Fhir::Resource
  invariants do
    validates_presence_of :master_identifier
    validates_presence_of :subject_ref
    validates_presence_of :status
    validates_presence_of :content_ref
  end

  # Extensions that cannot be ignored
  attribute :modifier_extension, Array[Fhir::Extension]

  # Text summary of the resource, for human interpretation
  attribute :text, Fhir::Narrative

  # Unique Identifier for the set of documents
  attribute :master_identifier, Fhir::Identifier

  # Other identifiers for the manifest
  attribute :identifier, Array[Fhir::Identifier]

  # The subject of the set of documents
  resource_references :subject, [Fhir::Patient, Fhir::Practitioner, Fhir::Group, Fhir::Device]

  # Intended to get notified about this set of documents
  resource_references :recipient, [Fhir::Patient, Fhir::Practitioner, Fhir::Organization]

  # What kind of document set this is
  attribute :type, Fhir::CodeableConcept

  # Who/what authored the document
  resource_references :author, [Fhir::Practitioner, Fhir::Device, Fhir::Patient, Fhir::RelatedPerson]

  # When this document manifest created
  attribute :created, DateTime

  # The source system/application/software
  attribute :source, Fhir::URI

  # current | superceded | entered in error
  attribute :status, Fhir::Code

  # If this document manifest replaces another
  resource_reference :supercedes, [Fhir::DocumentManifest]

  # Human-readable description (title)
  attribute :description, String

  # Sensitivity of set of documents
  attribute :confidentiality, Fhir::CodeableConcept

  # Contents of this set of documents
  resource_references :content, [Fhir::DocumentReference, Fhir::Binary, Fhir::Media]
end


Fhir.load_extension('document_manifest')
