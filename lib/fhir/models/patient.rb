class Patient
  attribute :extension, Extension
  attribute :text, Narrative
  attribute :contained, Resource
  attribute :identifier, Identifier
  attribute :name, HumanName
  attribute :telecom, Contact
  attribute :gender, CodeableConcept
  attribute :birthDate, DateTime
  attribute :deceased[x], boolean
  attribute :address, Address
  attribute :maritalStatus, CodeableConcept
  attribute :multipleBirth[x], boolean
  attribute :photo, Attachment
  attribute :contact, Contact
  class Contact
    attribute :relationship, CodeableConcept
    attribute :name, HumanName
    attribute :telecom, Contact
    attribute :address, Address
    attribute :gender, CodeableConcept
    attribute :organization, Resource(Organization)
  end
  attribute :animal, Animal
  class Animal
    attribute :species, CodeableConcept
    attribute :breed, CodeableConcept
    attribute :genderStatus, CodeableConcept
  end
  attribute :communication, CodeableConcept
  attribute :provider, Resource(Organization)
  attribute :link, Resource(Patient)
  attribute :active, boolean
end
