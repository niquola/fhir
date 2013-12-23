# Demographics and other administrative information about a
# person or animal receiving care or other health-related
# services.
class Fhir::Patient < Fhir::Resource
  # Extensions that cannot be ignored
  attribute :modifier_extension, Array[Fhir::Extension]

  # Text summary of the resource, for human interpretation
  attribute :text, Fhir::Narrative

  # An identifier for the person as this patient
  attribute :identifier, Array[Fhir::Identifier]

  # A name associated with the patient
  attribute :name, Array[Fhir::HumanName]

  # A contact detail for the individual
  attribute :telecom, Array[Fhir::Contact]

  # Gender for administrative purposes
  attribute :gender, Fhir::CodeableConcept

  # The date and time of birth for the individual
  attribute :birth_date, DateTime

  # Indicates if the individual is deceased or not
  attribute :deceased, *Fhir::Type[Boolean, DateTime]

  # Addresses for the individual
  attribute :address, Array[Fhir::Address]

  # Marital (civil) status of a person
  attribute :marital_status, Fhir::CodeableConcept

  # Whether patient is part of a multiple birth
  attribute :multiple_birth, *Fhir::Type[Boolean, Integer]

  # Image of the person
  attribute :photo, Array[Fhir::Attachment]

  # A contact party (e.g. guardian, partner, friend) for the
  # patient.
  class Contact < Fhir::ValueObject
    # Extensions that cannot be ignored
    attribute :modifier_extension, Array[Fhir::Extension]

    # The kind of relationship
    attribute :relationship, Array[Fhir::CodeableConcept]

    # A name associated with the person
    attribute :name, Fhir::HumanName

    # A contact detail for the person
    attribute :telecom, Array[Fhir::Contact]

    # Address for the contact person
    attribute :address, Fhir::Address

    # Gender for administrative purposes
    attribute :gender, Fhir::CodeableConcept

    # Organization that is associated with the contact
    resource_reference :organization, [Fhir::Organization]
  end

  attribute :contact, Array[Contact]

  # This element has a value if the patient is an animal.
  class Animal < Fhir::ValueObject
    invariants do
      validates_presence_of :species
    end

    # Extensions that cannot be ignored
    attribute :modifier_extension, Array[Fhir::Extension]

    # E.g. Dog, Cow
    attribute :species, Fhir::CodeableConcept

    # E.g. Poodle, Angus
    attribute :breed, Fhir::CodeableConcept

    # E.g. Neutered, Intact
    attribute :gender_status, Fhir::CodeableConcept
  end

  attribute :animal, Animal

  # Languages which may be used to communicate with the
  # patient about his or her health
  attribute :communication, Array[Fhir::CodeableConcept]

  # Patient's nominated care provider
  resource_references :care_provider, [Fhir::Organization, Fhir::Practitioner]

  # Organization that is the custodian of the patient record
  resource_reference :managing_organization, [Fhir::Organization]

  # Link to another patient resource that concerns the same
  # actual person.
  class Link < Fhir::ValueObject
    invariants do
      validates_presence_of :other_ref
      validates_presence_of :type
    end

    # Extensions that cannot be ignored
    attribute :modifier_extension, Array[Fhir::Extension]

    # The other patient resource that the link refers to
    resource_reference :other, [Fhir::Patient]

    # replace | refer | seealso - type of link
    attribute :type, Fhir::Code
  end

  attribute :link, Array[Link]

  # Whether this patient's record is in active use
  attribute :active, Boolean
end


Fhir.load_extension('patient')
