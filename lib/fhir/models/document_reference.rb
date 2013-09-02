# A reference to a document.
class Fhir::DocumentReference < Fhir::Resource
  # Additional Content defined by implementations
  attribute :extensions, Array[Fhir::Extension] # Extension

  # Text summary of the resource, for human interpretation
  attribute :text, Fhir::Narrative # Narrative

  # Contained, inline Resources
  attribute :containeds, Array[Fhir::Resource] # Resource

  # Master Version Specific Identifier
  # Should be present
  attribute :master_identifier, Fhir::Identifier # Identifier

  # Other identifiers for the document
  attribute :identifiers, Array[Fhir::Identifier] # Identifier

  # The subject of the document
  # Should be present
  attribute :subject, Fhir::ResourceReference[Fhir::Patient, Fhir::Practitioner, Fhir::Group, Fhir::Device] # Resource(Patient|Practitioner|Group|Device)

  # What kind of document this is (LOINC if possible)
  # Should be present
  attribute :type, Fhir::CodeableConcept # CodeableConcept

  # More detail about the document type
  attribute :subtype, Fhir::CodeableConcept # CodeableConcept

  # Who/what authored the document
  # Should be present
  attribute :authors, Array[Fhir::ResourceReference[Fhir::Practitioner, Fhir::Device]] # Resource(Practitioner|Device)

  # Org which maintains the document
  attribute :custodian, Fhir::ResourceReference[Fhir::Organization] # Resource(Organization)

  # Who authenticated the document
  attribute :authenticator, Fhir::ResourceReference[Fhir::Practitioner, Fhir::Organization] # Resource(Practitioner|Organization)

  # Document creation time
  attribute :created, DateTime # dateTime

  # When this document reference created
  # Should be present
  attribute :indexed, DateTime # instant

  # current | superseded | error
  # Should be present
  attribute :status, Fhir::Code # code

  # Status of the underlying document
  attribute :doc_status, Fhir::CodeableConcept # CodeableConcept

  # If this document replaces another
  attribute :supercedes, Fhir::ResourceReference[Fhir::DocumentReference] # Resource(DocumentReference)

  # Human Readable description (title)
  attribute :description, String # string

  # Sensitivity of source document
  attribute :confidentiality, Fhir::CodeableConcept # CodeableConcept

  # Primary language of the document
  attribute :primary_language, Fhir::Code # code

  # Mime type of the document
  # Should be present
  attribute :mime_type, Fhir::Code # code

  # Format of the document
  attribute :format, Fhir::CodeableConcept # CodeableConcept

  # Size of the document in bytes
  attribute :size, Integer # integer

  # HexBinary representation of SHA1
  attribute :hash, String # string

  # Where to access the document
  attribute :location, Fhir::URI # uri

  # A description of a service call that can be used to
  # retrieve the document.
  class Service < Fhir::ValueObject
    # Type of service (i.e. XDS.b)
    # Should be present
    attribute :type, Fhir::CodeableConcept # CodeableConcept

    # Where service is located (usually a URL)
    attribute :address, String # string

    # A list of named parameters that is used in the service
    # call.
    class Parameter < Fhir::ValueObject
      # Name of parameter
      # Should be present
      attribute :name, String # string

      # Parameter value
      attribute :value, String # string
    end

    attribute :parameters, Array[Parameter] # 
  end

  attribute :service, Service # 

  # The clinical context in which the document was prepared.
  class Context < Fhir::ValueObject
    # Type of context (i.e. type of event)
    attribute :codes, Array[Fhir::CodeableConcept] # CodeableConcept

    # Time described by the document
    attribute :period, Fhir::Period # Period

    # Kind of facility where patient was seen
    attribute :facility_type, Fhir::CodeableConcept # CodeableConcept
  end

  attribute :context, Context # 
end

