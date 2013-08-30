# Demographics and other administrative information about a
# person or animal receiving care or other health-related
# services.
class Fhir::Patient < Fhir::Resource
  # Additional Content defined by implementations
  attribute :extension, Array[Fhir::Extension] # Extension

  # Text summary of the resource, for human interpretation
  attribute :text, Fhir::Narrative # Narrative

  # Contained, inline Resources
  attribute :contained, Array[Fhir::Resource] # Resource

  # An identifier for the person as this patient
  attribute :identifier, Array[Fhir::Identifier] # Identifier

  # A name associated with the patient
  attribute :name, Array[Fhir::HumanName] # HumanName

  # A contact detail for the individual
  attribute :telecom, Array[Fhir::Contact] # Contact

  # Gender for administrative purposes
  attribute :gender, Fhir::CodeableConcept # CodeableConcept

  # The date and time of birth for the individual
  attribute :birth_date, DateTime # dateTime

  # Indicates if the individual is deceased or not
  attribute :deceased, Boolean # boolean

  # Addresses for the individual
  attribute :address, Array[Fhir::Address] # Address

  # Marital (civil) status of a person
  attribute :marital_status, Fhir::CodeableConcept # CodeableConcept

  # Whether patient is part of a multiple birth
  attribute :multiple_birth, Boolean # boolean

  # Image of the person
  attribute :photo, Array[Fhir::Attachment] # Attachment

  # A contact party (e.g. guardian, partner, friend) for the
  # patient.
  class Contact < Fhir::ValueObject
    # The kind of relationship
    attribute :relationship, Array[Fhir::CodeableConcept] # CodeableConcept

    # A name associated with the person
    attribute :name, Fhir::HumanName # HumanName

    # A contact detail for the person
    attribute :telecom, Array[Fhir::Contact] # Contact

    # Address for the contact person
    attribute :address, Fhir::Address # Address

    # Gender for administrative purposes
    attribute :gender, Fhir::CodeableConcept # CodeableConcept

    # Organization that is associated with the contact
    attribute :organization, Fhir::ResourceReference[Fhir::Organization] # Resource(Organization)
  end

  attribute :contact, Array[Contact] # 

  # This element has a value if the patient is an animal.
  class Animal < Fhir::ValueObject
    # E.g. Dog, Cow
    # Should be present
    attribute :species, Fhir::CodeableConcept # CodeableConcept

    # E.g. Poodle, Angus
    attribute :breed, Fhir::CodeableConcept # CodeableConcept

    # E.g. Neutered, Intact
    attribute :gender_status, Fhir::CodeableConcept # CodeableConcept
  end

  attribute :animal, Animal # 

  # Languages which may be used to communicate with the
  # patient
  attribute :communication, Array[Fhir::CodeableConcept] # CodeableConcept

  # Organization managing the patient
  attribute :provider, Fhir::ResourceReference[Fhir::Organization] # Resource(Organization)

  # Other patient resources linked to this resource
  attribute :link, Array[Fhir::ResourceReference[Fhir::Patient]] # Resource(Patient)

  # Whether this patient's record is in active use
  attribute :active, Boolean # boolean
end

