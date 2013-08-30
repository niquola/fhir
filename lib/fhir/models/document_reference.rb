# A reference to a document.
class Fhir::DocumentReference < Fhir::Resource
  # Additional Content defined by implementations
  attribute :extension, Array[Extension]

  # Text summary of the resource, for human interpretation
  attribute :text, Narrative

  # Contained, inline Resources
  attribute :contained, Array[ResourceLink[Resource]]

  # Master Version Specific Identifier
  # Should be present
  attribute :master_identifier, Identifier

  # Other identifiers for the document
  attribute :identifier, Array[Identifier]

  # The subject of the document
  # Should be present
  attribute :subject, ResourceLink[Patient, Practitioner, Group, Device]

  # What kind of document this is (LOINC if possible)
  # Should be present
  attribute :type, CodeableConcept

  # More detail about the document type
  attribute :subtype, CodeableConcept

  # Who/what authored the document
  # Should be present
  attribute :author, Array[ResourceLink[Practitioner, Device]]

  # Org which maintains the document
  attribute :custodian, ResourceLink[Organization]

  # Who authenticated the document
  attribute :authenticator, ResourceLink[Practitioner, Organization]

  # Document creation time
  attribute :created, dateTime

  # When this document reference created
  # Should be present
  attribute :indexed, instant

  # current | superseded | error
  # Should be present
  attribute :status, code

  # Status of the underlying document
  attribute :doc_status, CodeableConcept

  # If this document replaces another
  attribute :supercedes, ResourceLink[DocumentReference]

  # Human Readable description (title)
  attribute :description, string

  # Sensitivity of source document
  attribute :confidentiality, CodeableConcept

  # Primary language of the document
  attribute :primary_language, code

  # Mime type of the document
  # Should be present
  attribute :mime_type, code

  # Format of the document
  attribute :format, CodeableConcept

  # Size of the document in bytes
  attribute :size, integer

  # HexBinary representation of SHA1
  attribute :hash, string

  # Where to access the document
  attribute :location, uri

  # A description of a service call that can be used to
  # retrieve the document.
  class Service < Fhir::ValueObject
    # Type of service (i.e. XDS.b)
    # Should be present
    attribute :type, CodeableConcept

    # Where service is located (usually a URL)
    attribute :address, string

    # A list of named parameters that is used in the service
    # call.
    class Parameter < Fhir::ValueObject
      # Name of parameter
      # Should be present
      attribute :name, string

      # Parameter value
      attribute :value, string
    end

    attribute :parameter, Array[Parameter]
  end

  attribute :service, Service

  # The clinical context in which the document was prepared.
  class Context < Fhir::ValueObject
    # Type of context (i.e. type of event)
    attribute :code, Array[CodeableConcept]

    # Time described by the document
    attribute :period, Period

    # Kind of facility where patient was seen
    attribute :facility_type, CodeableConcept
  end

  attribute :context, Context
end

