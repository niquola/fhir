# A reference to a document.
class Fhir::DocumentReference < Fhir::Resource
  invariants do
    validates_presence_of :master_identifier
    validates_presence_of :subject_ref
    validates_presence_of :type
    validates_presence_of :author_ref
    validates_presence_of :indexed
    validates_presence_of :status
    validates_presence_of :mime_type
  end

  # Extensions that cannot be ignored
  attribute :modifier_extension, Array[Fhir::Extension]

  # Text summary of the resource, for human interpretation
  attribute :text, Fhir::Narrative

  # Master Version Specific Identifier
  attribute :master_identifier, Fhir::Identifier

  # Other identifiers for the document
  attribute :identifier, Array[Fhir::Identifier]

  # Who|what is the subject of the document
  resource_reference :subject, [Fhir::Patient, Fhir::Practitioner, Fhir::Group, Fhir::Device]

  # What kind of document this is (LOINC if possible)
  attribute :type, Fhir::CodeableConcept

  # Categorisation of Document
  attribute :document_reference_class, Fhir::CodeableConcept

  # Who/what authored the document
  resource_references :author, [Fhir::Practitioner, Fhir::Device, Fhir::Patient, Fhir::RelatedPerson]

  # Org which maintains the document
  resource_reference :custodian, [Fhir::Organization]

  # Manages access policies for the document
  attribute :policy_manager, Fhir::URI

  # Who/What authenticated the document
  resource_reference :authenticator, [Fhir::Practitioner, Fhir::Organization]

  # Document creation time
  attribute :created, DateTime

  # When this document reference created
  attribute :indexed, DateTime

  # current | superceded | entered in error
  attribute :status, Fhir::Code

  # preliminary | final | appended | amended | entered in
  # error
  attribute :doc_status, Fhir::CodeableConcept

  # Relationships that this document has with other document
  # references that already exist.
  class RelatesTo < Fhir::ValueObject
    invariants do
      validates_presence_of :code
      validates_presence_of :target_ref
    end

    # Extensions that cannot be ignored
    attribute :modifier_extension, Array[Fhir::Extension]

    # replaces | transforms | signs | appends
    attribute :code, Fhir::Code

    # Target of the relationship
    resource_reference :target, [Fhir::DocumentReference]
  end

  attribute :relates_to, Array[RelatesTo]

  # Human-readable description (title)
  attribute :description, String

  # Sensitivity of source document
  attribute :confidentiality, Array[Fhir::CodeableConcept]

  # The marked primary language for the document
  attribute :primary_language, Fhir::Code

  # Mime type, + maybe character encoding
  attribute :mime_type, Fhir::Code

  # Format/content rules for the document
  attribute :format, Array[Fhir::URI]

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

    # Extensions that cannot be ignored
    attribute :modifier_extension, Array[Fhir::Extension]

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

      # Extensions that cannot be ignored
      attribute :modifier_extension, Array[Fhir::Extension]

      # Parameter name in service call
      attribute :name, String

      # Parameter value for the name
      attribute :value, String
    end

    attribute :parameter, Array[Parameter]
  end

  attribute :service, Service

  # The clinical context in which the document was prepared.
  class Context < Fhir::ValueObject
    # Extensions that cannot be ignored
    attribute :modifier_extension, Array[Fhir::Extension]

    # Main Clinical Acts Documented
    attribute :event, Array[Fhir::CodeableConcept]

    # Time of service that is being documented
    attribute :period, Fhir::Period

    # Kind of facility where patient was seen
    attribute :facility_type, Fhir::CodeableConcept
  end

  attribute :context, Context
end


Fhir.load_extension('document_reference')
