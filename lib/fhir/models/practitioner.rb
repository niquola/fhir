# Demographics and qualification information for an
# individual who is directly or indirectly involved in the
# provisioning of healthcare.
class Fhir::Practitioner < Fhir::Resource
  # Additional Content defined by implementations
  attribute :extension, Array[Fhir::Extension] # Extension

  # Text summary of the resource, for human interpretation
  attribute :text, Fhir::Narrative # Narrative

  # Contained, inline Resources
  attribute :contained, Array[Fhir::Resource] # Resource

  # A identifier for the person as this agent
  attribute :identifier, Array[Fhir::Identifier] # Identifier

  # A name associated with the person
  attribute :name, Fhir::HumanName # HumanName

  # A contact detail for the practitioner
  attribute :telecom, Array[Fhir::Contact] # Contact

  # One or more addresses for the practitioner
  attribute :address, Fhir::Address # Address

  # Gender for administrative purposes
  attribute :gender, Fhir::CodeableConcept # CodeableConcept

  # The date and time of birth for the practitioner
  attribute :birth_date, DateTime # dateTime

  # Image of the person
  attribute :photo, Array[Fhir::Attachment] # Attachment

  # The represented organization
  attribute :organization, Fhir::ResourceReference[Fhir::Organization] # Resource(Organization)

  # A role the practitioner has
  attribute :role, Array[Fhir::CodeableConcept] # CodeableConcept

  # Specific specialty of the practitioner
  attribute :specialty, Array[Fhir::CodeableConcept] # CodeableConcept

  # The period during which the person is authorized to
  # perform the service
  attribute :period, Fhir::Period # Period

  # Qualifications relevant to the provided service.
  class Qualification < Fhir::ValueObject
    # Qualification
    # Should be present
    attribute :code, Fhir::CodeableConcept # CodeableConcept

    # Period during which the qualification is valid
    attribute :period, Fhir::Period # Period

    # Organization that regulates and issues the qualification
    attribute :issuer, Fhir::ResourceReference[Fhir::Organization] # Resource(Organization)
  end

  attribute :qualification, Array[Qualification] # 

  # A language the practitioner is able to use in patient
  # communication
  attribute :communication, Array[Fhir::CodeableConcept] # CodeableConcept
end

