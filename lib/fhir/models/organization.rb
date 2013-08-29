class Organization
  attribute :extension, Extension
  attribute :text, Narrative
  attribute :contained, Resource
  attribute :identifier, Identifier
  attribute :name, String
  attribute :type, CodeableConcept
  attribute :telecom, Contact
  attribute :address, Address
  attribute :partOf, Resource(Organization)
  attribute :contact, Contact
  class Contact
    attribute :purpose, CodeableConcept
    attribute :name, HumanName
    attribute :telecom, Contact
    attribute :address, Address
    attribute :gender, CodeableConcept
  end
  attribute :active, boolean
end
