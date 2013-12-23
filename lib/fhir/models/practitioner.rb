# Demographics and qualification information for an
# individual who is directly or indirectly involved in the
# provisioning of healthcare.
class Fhir::Practitioner < Fhir::Resource
  # Extensions that cannot be ignored
  attribute :modifier_extension, Array[Fhir::Extension]

  # Text summary of the resource, for human interpretation
  attribute :text, Fhir::Narrative

  # A identifier for the person as this agent
  attribute :identifier, Array[Fhir::Identifier]

  # A name associated with the person
  attribute :name, Fhir::HumanName

  # A contact detail for the practitioner
  attribute :telecom, Array[Fhir::Contact]

  # One or more addresses for the practitioner
  attribute :address, Fhir::Address

  # Gender for administrative purposes
  attribute :gender, Fhir::CodeableConcept

  # The date and time of birth for the practitioner
  attribute :birth_date, DateTime

  # Image of the person
  attribute :photo, Array[Fhir::Attachment]

  # The represented organization
  resource_reference :organization, [Fhir::Organization]

  # Roles which this practitioner may perform
  attribute :role, Array[Fhir::CodeableConcept]

  # Specific specialty of the practitioner
  attribute :specialty, Array[Fhir::CodeableConcept]

  # The period during which the practitioner is authorized to
  # perform in these role(s)
  attribute :period, Fhir::Period

  # The location(s) at which this practitioner provides care
  resource_references :location, [Fhir::Location]

  # Qualifications obtained by training and certification.
  class Qualification < Fhir::ValueObject
    invariants do
      validates_presence_of :code
    end

    # Extensions that cannot be ignored
    attribute :modifier_extension, Array[Fhir::Extension]

    # Coded representation of the qualification
    attribute :code, Fhir::CodeableConcept

    # Period during which the qualification is valid
    attribute :period, Fhir::Period

    # Organization that regulates and issues the qualification
    resource_reference :issuer, [Fhir::Organization]
  end

  attribute :qualification, Array[Qualification]

  # A language the practitioner is able to use in patient
  # communication
  attribute :communication, Array[Fhir::CodeableConcept]
end


Fhir.load_extension('practitioner')
