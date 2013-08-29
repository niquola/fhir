class Organization
  include Virtus
  # Additional Content defined by implementations
  attribute :extension, Extension

  # Text summary of the resource, for human interpretation
  attribute :text, Narrative

  # Contained, inline Resources
  attribute :contained, Resource

  # Identifier for this organization
  attribute :identifier, Identifier

  # Name used for the organization
  attribute :name, String

  # Kind of organization
  attribute :type, CodeableConcept

  # A contact detail for the organization
  attribute :telecom, Contact

  # An address for the organization
  attribute :address, Address

  # The organization of which this organization forms a part
  attribute :partOf, Resource(Organization)

  # Contact for the organization
  attribute :contact, Contact

  class Contact
    include Virtus::ValueObject
    # The type of contact
    attribute :purpose, CodeableConcept

    # A name associated with the contact
    attribute :name, HumanName

    # Contact details (telephone, email, etc)  for a contact
    attribute :telecom, Contact

    # Visiting or postal addresses for the contact
    attribute :address, Address

    # Gender for administrative purposes
    attribute :gender, CodeableConcept

  end
  # Whether the organization's record is still in active use
  attribute :active, boolean

end
