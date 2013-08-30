# Demographics and other administrative information about a
# person or animal receiving care or other health-related
# services.
class Fhir::Patient < Fhir::Resource
  # Additional Content defined by implementations
  attribute :extension, Array[Extension]

  # Text summary of the resource, for human interpretation
  attribute :text, Narrative

  # Contained, inline Resources
  attribute :contained, Array[ResourceLink[Resource]]

  # An identifier for the person as this patient
  attribute :identifier, Array[Identifier]

  # A name associated with the patient
  attribute :name, Array[HumanName]

  # A contact detail for the individual
  attribute :telecom, Array[Contact]

  # Gender for administrative purposes
  attribute :gender, CodeableConcept

  # The date and time of birth for the individual
  attribute :birth_date, dateTime

  # Indicates if the individual is deceased or not
  attribute :deceased[x], boolean

  # Addresses for the individual
  attribute :address, Array[Address]

  # Marital (civil) status of a person
  attribute :marital_status, CodeableConcept

  # Whether patient is part of a multiple birth
  attribute :multiple_birth[x], boolean

  # Image of the person
  attribute :photo, Array[Attachment]

  # A contact party (e.g. guardian, partner, friend) for the
  # patient.
  class Contact < Fhir::ValueObject
    # The kind of relationship
    attribute :relationship, Array[CodeableConcept]

    # A name associated with the person
    attribute :name, HumanName

    # A contact detail for the person
    attribute :telecom, Array[Contact]

    # Address for the contact person
    attribute :address, Address

    # Gender for administrative purposes
    attribute :gender, CodeableConcept

    # Organization that is associated with the contact
    attribute :organization, ResourceLink[Organization]
  end

  attribute :contact, Array[Contact]

  # This element has a value if the patient is an animal.
  class Animal < Fhir::ValueObject
    # E.g. Dog, Cow
    # Should be present
    attribute :species, CodeableConcept

    # E.g. Poodle, Angus
    attribute :breed, CodeableConcept

    # E.g. Neutered, Intact
    attribute :gender_status, CodeableConcept
  end

  attribute :animal, Animal

  # Languages which may be used to communicate with the
  # patient
  attribute :communication, Array[CodeableConcept]

  # Organization managing the patient
  attribute :provider, ResourceLink[Organization]

  # Other patient resources linked to this resource
  attribute :link, Array[ResourceLink[Patient]]

  # Whether this patient's record is in active use
  attribute :active, boolean
end

