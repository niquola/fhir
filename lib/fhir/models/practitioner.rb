# Demographics and qualification information for an
# individual who is directly or indirectly involved in the
# provisioning of healthcare.
class Fhir::Practitioner < Fhir::Resource
  # Text summary of the resource, for human interpretation
  attribute :text, Fhir::Narrative

  # A identifier for the person as this agent
  attribute :identifiers, Array[Fhir::Identifier]

  # A name associated with the person
  attribute :name, Fhir::HumanName

  # A contact detail for the practitioner
  attribute :telecoms, Array[Fhir::Contact]

  # One or more addresses for the practitioner
  attribute :address, Fhir::Address

  # Gender for administrative purposes
  attribute :gender, Fhir::CodeableConcept

  # The date and time of birth for the practitioner
  attribute :birth_date, DateTime

  # Image of the person
  attribute :photos, Array[Fhir::Attachment]

  # The represented organization
  resource_reference :organization, [Fhir::Organization]

  # A role the practitioner has
  attribute :roles, Array[Fhir::CodeableConcept]

  # Specific specialty of the practitioner
  attribute :specialties, Array[Fhir::CodeableConcept]

  # The period during which the person is authorized to
  # perform the service
  attribute :period, Fhir::Period

  # Qualifications relevant to the provided service.
  class Qualification < Fhir::ValueObject
    invariants do
      validates_presence_of :code
    end

    # Qualification
    attribute :code, Fhir::CodeableConcept

    # Period during which the qualification is valid
    attribute :period, Fhir::Period

    # Organization that regulates and issues the qualification
    resource_reference :issuer, [Fhir::Organization]
  end

  attribute :qualifications, Array[Qualification]

  # A language the practitioner is able to use in patient
  # communication
  attribute :communications, Array[Fhir::CodeableConcept]
end


Fhir.load_handmade('models/practitioner')
