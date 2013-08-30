# Demographics and qualification information for an
# individual who is directly or indirectly involved in the
# provisioning of healthcare.
class Fhir::Practitioner < Fhir::Resource
  # Additional Content defined by implementations
  attribute :extension, Array[Extension]

  # Text summary of the resource, for human interpretation
  attribute :text, Narrative

  # Contained, inline Resources
  attribute :contained, Array[ResourceLink[Resource]]

  # A identifier for the person as this agent
  attribute :identifier, Array[Identifier]

  # A name associated with the person
  attribute :name, HumanName

  # A contact detail for the practitioner
  attribute :telecom, Array[Contact]

  # One or more addresses for the practitioner
  attribute :address, Address

  # Gender for administrative purposes
  attribute :gender, CodeableConcept

  # The date and time of birth for the practitioner
  attribute :birth_date, dateTime

  # Image of the person
  attribute :photo, Array[Attachment]

  # The represented organization
  attribute :organization, ResourceLink[Organization]

  # A role the practitioner has
  attribute :role, Array[CodeableConcept]

  # Specific specialty of the practitioner
  attribute :specialty, Array[CodeableConcept]

  # The period during which the person is authorized to
  # perform the service
  attribute :period, Period

  # Qualifications relevant to the provided service.
  class Qualification < Fhir::ValueObject
    # Qualification
    # Should be present
    attribute :code, CodeableConcept

    # Period during which the qualification is valid
    attribute :period, Period

    # Organization that regulates and issues the qualification
    attribute :issuer, ResourceLink[Organization]
  end

  attribute :qualification, Array[Qualification]

  # A language the practitioner is able to use in patient
  # communication
  attribute :communication, Array[CodeableConcept]
end

