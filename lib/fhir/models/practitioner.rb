# A person with a  formal responsibility in the provisioning of healthcare or related services
class Practitioner
  include Virtus
  # Additional Content defined by implementations
  attribute :extension, Extension

  # Text summary of the resource, for human interpretation
  attribute :text, Narrative

  # Contained, inline Resources
  attribute :contained, Resource

  # A identifier for the person as this agent
  attribute :identifier, Identifier

  # A name associated with the person
  attribute :name, HumanName

  # A contact detail for the practitioner
  attribute :telecom, Contact

  # One or more addresses for the practitioner
  attribute :address, Address

  # Gender for administrative purposes
  attribute :gender, CodeableConcept

  # The date and time of birth for the practitioner
  attribute :birthDate, DateTime

  # Image of the person
  attribute :photo, Attachment

  # The represented organization
  attribute :organization, Resource(Organization)

  # A role the practitioner has
  attribute :role, CodeableConcept

  # Specific specialty of the practitioner
  attribute :specialty, CodeableConcept

  # The period during which the person is authorized to perform the service
  attribute :period, Period

  # Qualifications relevant to the provided service
  attribute :qualification, Qualification

  class Qualification
    include Virtus::ValueObject
    # Qualification
    attribute :code, CodeableConcept

    # Period during which the qualification is valid
    attribute :period, Period

    # Organization that regulates and issues the qualification
    attribute :issuer, Resource(Organization)

  end
  # A language the practitioner is able to use in patient communication
  attribute :communication, CodeableConcept

end
