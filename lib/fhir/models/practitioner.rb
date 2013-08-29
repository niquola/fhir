class Practitioner
  attribute :extension, Extension
  attribute :text, Narrative
  attribute :contained, Resource
  attribute :identifier, Identifier
  attribute :name, HumanName
  attribute :telecom, Contact
  attribute :address, Address
  attribute :gender, CodeableConcept
  attribute :birthDate, DateTime
  attribute :photo, Attachment
  attribute :organization, Resource(Organization)
  attribute :role, CodeableConcept
  attribute :specialty, CodeableConcept
  attribute :period, Period
  attribute :qualification, Qualification
  class Qualification
    attribute :code, CodeableConcept
    attribute :period, Period
    attribute :issuer, Resource(Organization)
  end
  attribute :communication, CodeableConcept
end
