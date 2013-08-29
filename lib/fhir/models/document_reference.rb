class DocumentReference
  include Virtus
  # Additional Content defined by implementations
  attribute :extension, Extension

  # Text summary of the resource, for human interpretation
  attribute :text, Narrative

  # Contained, inline Resources
  attribute :contained, Resource

  # Master Version Specific Identifier
  attribute :masterIdentifier, Identifier

  # Other identifiers for the document
  attribute :identifier, Identifier

  # The subject of the document
  attribute :subject, Resource(Patient|Practitioner|Group|Device)

  # What kind of document this is (LOINC if possible)
  attribute :type, CodeableConcept

  # More detail about the document type
  attribute :subtype, CodeableConcept

  # Who/what authored the document
  attribute :author, Resource(Practitioner|Device)

  # Org which maintains the document
  attribute :custodian, Resource(Organization)

  # Who authenticated the document
  attribute :authenticator, Resource(Practitioner|Organization)

  # Document creation time
  attribute :created, DateTime

  # When this document reference created
  attribute :indexed, instant

  # current | superseded | error
  attribute :status, code

  # Status of the underlying document
  attribute :docStatus, CodeableConcept

  # If this document replaces another
  attribute :supercedes, Resource(DocumentReference)

  # Human Readable description (title)
  attribute :description, String

  # Sensitivity of source document
  attribute :confidentiality, CodeableConcept

  # Primary language of the document
  attribute :primaryLanguage, code

  # Mime type of the document
  attribute :mimeType, code

  # Format of the document
  attribute :format, CodeableConcept

  # Size of the document in bytes
  attribute :size, integer

  # HexBinary representation of SHA1
  attribute :hash, String

  # Where to access the document
  attribute :location, uri

  # If access is not fully described by location
  attribute :service, Service

  class Service
    include Virtus::ValueObject
    # Type of service (i.e. XDS.b)
    attribute :type, CodeableConcept

    # Where service is located (usually a URL)
    attribute :address, String

    # Service call parameters
    attribute :parameter, Parameter

    class Parameter
      include Virtus::ValueObject
      # Name of parameter
      attribute :name, String

      # Parameter value
      attribute :value, String

    end
  end
  # Clinical context of document
  attribute :context, Context

  class Context
    include Virtus::ValueObject
    # Type of context (i.e. type of event)
    attribute :code, CodeableConcept

    # Time described by the document
    attribute :period, Period

    # Kind of facility where patient was seen
    attribute :facilityType, CodeableConcept

  end
end
