# A reference to a document.
class Fhir::DocumentReference < Fhir::Resource
  invariants do
    validates_presence_of :master_identifier
    validates_presence_of :subject_ref
    validates_presence_of :type
    validates_presence_of :author_refs
    validates_presence_of :indexed
    validates_presence_of :status
    validates_presence_of :mime_type
  end

  # Text summary of the resource, for human interpretation
  attribute :text, Fhir::Narrative

  # Master Version Specific Identifier
  attribute :master_identifier, Fhir::Identifier

  # Other identifiers for the document
  attribute :identifiers, Array[Fhir::Identifier]

  # The subject of the document
  resource_reference :subject, [Fhir::Patient, Fhir::Practitioner, Fhir::Group, Fhir::Device]

  # What kind of document this is (LOINC if possible)
  attribute :type, Fhir::CodeableConcept

  # More detail about the document type
  attribute :subtype, Fhir::CodeableConcept

  # Who/what authored the document
  resource_references :authors, [Fhir::Practitioner, Fhir::Device]

  # Org which maintains the document
  resource_reference :custodian, [Fhir::Organization]

  # Who authenticated the document
  resource_reference :authenticator, [Fhir::Practitioner, Fhir::Organization]

  # Document creation time
  attribute :created, DateTime

  # When this document reference created
  attribute :indexed, DateTime

  # current | superseded | error
  attribute :status, Fhir::Code

  # Status of the underlying document
  attribute :doc_status, Fhir::CodeableConcept

  # If this document replaces another
  resource_reference :supercedes, [Fhir::DocumentReference]

  # Human Readable description (title)
  attribute :description, String

  # Sensitivity of source document
  attribute :confidentiality, Fhir::CodeableConcept

  # Primary language of the document
  attribute :primary_language, Fhir::Code

  # Mime type of the document
  attribute :mime_type, Fhir::Code

  # Format of the document
  attribute :format, Fhir::CodeableConcept

  # Size of the document in bytes
  attribute :size, Integer

  # HexBinary representation of SHA1
  attribute :hash, String

  # Where to access the document
  attribute :location, Fhir::URI

  # A description of a service call that can be used to
  # retrieve the document.
  class Service < Fhir::ValueObject
    invariants do
      validates_presence_of :type
    end

    # Type of service (i.e. XDS.b)
    attribute :type, Fhir::CodeableConcept

    # Where service is located (usually a URL)
    attribute :address, String

    # A list of named parameters that is used in the service
    # call.
    class Parameter < Fhir::ValueObject
      invariants do
        validates_presence_of :name
      end

      # Name of parameter
      attribute :name, String

      # Parameter value
      attribute :value, String
    end

    attribute :parameters, Array[Parameter]
  end

  attribute :service, Service

  # The clinical context in which the document was prepared.
  class Context < Fhir::ValueObject
    # Type of context (i.e. type of event)
    attribute :codes, Array[Fhir::CodeableConcept]

    # Time described by the document
    attribute :period, Fhir::Period

    # Kind of facility where patient was seen
    attribute :facility_type, Fhir::CodeableConcept
  end

  attribute :context, Context
end


Fhir.load_handmade('models/document_reference')
