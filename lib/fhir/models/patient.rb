class Patient
  include Virtus
  # Additional Content defined by implementations
  attribute :extension, Extension

  # Text summary of the resource, for human interpretation
  attribute :text, Narrative

  # Contained, inline Resources
  attribute :contained, Resource

  # An identifier for the person as this patient
  attribute :identifier, Identifier

  # A name associated with the patient
  attribute :name, HumanName

  # A contact detail for the individual
  attribute :telecom, Contact

  # Gender for administrative purposes
  attribute :gender, CodeableConcept

  # The date and time of birth for the individual
  attribute :birthDate, DateTime

  # Indicates if the individual is deceased or not
  attribute :deceased[x], boolean

  # Addresses for the individual
  attribute :address, Address

  # Marital (civil) status of a person
  attribute :maritalStatus, CodeableConcept

  # Whether patient is part of a multiple birth
  attribute :multipleBirth[x], boolean

  # Image of the person
  attribute :photo, Attachment

  # A contact party (e.g. guardian, partner, friend) for the patient
  attribute :contact, Contact

  class Contact
    include Virtus::ValueObject
    # The kind of relationship
    attribute :relationship, CodeableConcept

    # A name associated with the person
    attribute :name, HumanName

    # A contact detail for the person
    attribute :telecom, Contact

    # Address for the contact person
    attribute :address, Address

    # Gender for administrative purposes
    attribute :gender, CodeableConcept

    # Organization that is associated with the contact
    attribute :organization, Resource(Organization)

  end
  # If this patient is an animal (non-human)
  attribute :animal, Animal

  class Animal
    include Virtus::ValueObject
    # E.g. Dog, Cow
    attribute :species, CodeableConcept

    # E.g. Poodle, Angus
    attribute :breed, CodeableConcept

    # E.g. Neutered, Intact
    attribute :genderStatus, CodeableConcept

  end
  # Languages which may be used to communicate with the patient
  attribute :communication, CodeableConcept

  # Organization managing the patient
  attribute :provider, Resource(Organization)

  # Other patient resources linked to this resource
  attribute :link, Resource(Patient)

  # Whether this patient's record is in active use
  attribute :active, boolean

end
