class DocumentReference
  attribute :extension, Extension
  attribute :text, Narrative
  attribute :contained, Resource
  attribute :masterIdentifier, Identifier
  attribute :identifier, Identifier
  attribute :subject, Resource(Patient|Practitioner|Group|Device)
  attribute :type, CodeableConcept
  attribute :subtype, CodeableConcept
  attribute :author, Resource(Practitioner|Device)
  attribute :custodian, Resource(Organization)
  attribute :authenticator, Resource(Practitioner|Organization)
  attribute :created, DateTime
  attribute :indexed, instant
  attribute :status, code
  attribute :docStatus, CodeableConcept
  attribute :supercedes, Resource(DocumentReference)
  attribute :description, String
  attribute :confidentiality, CodeableConcept
  attribute :primaryLanguage, code
  attribute :mimeType, code
  attribute :format, CodeableConcept
  attribute :size, integer
  attribute :hash, String
  attribute :location, uri
  attribute :service, Service
  class Service
    attribute :type, CodeableConcept
    attribute :address, String
    attribute :parameter, Parameter
    class Parameter
      attribute :name, String
      attribute :value, String
    end
  end
  attribute :context, Context
  class Context
    attribute :code, CodeableConcept
    attribute :period, Period
    attribute :facilityType, CodeableConcept
  end
end
