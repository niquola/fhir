# Demographics and other administrative information about a
# person or animal receiving care or other health-related
# services.
class Fhir::Patient < Fhir::Resource
  # Text summary of the resource, for human interpretation
  attribute :text, Fhir::Narrative

  # An identifier for the person as this patient
  attribute :identifiers, Array[Fhir::Identifier]

  # A name associated with the patient
  attribute :names, Array[Fhir::HumanName]

  # A contact detail for the individual
  attribute :telecoms, Array[Fhir::Contact]

  # Gender for administrative purposes
  attribute :gender, Fhir::CodeableConcept

  # The date and time of birth for the individual
  attribute :birth_date, DateTime

  # Indicates if the individual is deceased or not
  attribute :deceased, *Fhir::Type[Boolean, DateTime]

  # Addresses for the individual
  attribute :addresses, Array[Fhir::Address]

  # Marital (civil) status of a person
  attribute :marital_status, Fhir::CodeableConcept

  # Whether patient is part of a multiple birth
  attribute :multiple_birth, *Fhir::Type[Boolean, Integer]

  # Image of the person
  attribute :photos, Array[Fhir::Attachment]

  # A contact party (e.g. guardian, partner, friend) for the
  # patient.
  class Contact < Fhir::ValueObject
    # The kind of relationship
    attribute :relationships, Array[Fhir::CodeableConcept]

    # A name associated with the person
    attribute :name, Fhir::HumanName

    # A contact detail for the person
    attribute :telecoms, Array[Fhir::Contact]

    # Address for the contact person
    attribute :address, Fhir::Address

    # Gender for administrative purposes
    attribute :gender, Fhir::CodeableConcept

    # Organization that is associated with the contact
    resource_reference :organization, [Fhir::Organization]
  end

  attribute :contacts, Array[Contact]

  # This element has a value if the patient is an animal.
  class Animal < Fhir::ValueObject
    invariants do
      validates_presence_of :species
    end

    # E.g. Dog, Cow
    attribute :species, Fhir::CodeableConcept

    # E.g. Poodle, Angus
    attribute :breed, Fhir::CodeableConcept

    # E.g. Neutered, Intact
    attribute :gender_status, Fhir::CodeableConcept
  end

  attribute :animal, Animal

  # Languages which may be used to communicate with the
  # patient
  attribute :communications, Array[Fhir::CodeableConcept]

  # Organization managing the patient
  resource_reference :provider, [Fhir::Organization]

  # Other patient resources linked to this resource
  resource_references :links, [Fhir::Patient]

  # Whether this patient's record is in active use
  attribute :active, Boolean
end


Fhir.load_extension('patient')
