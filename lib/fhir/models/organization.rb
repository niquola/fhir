# A formally or informally recognized grouping of people or
# organizations formed for the purpose of achieving some form
# of collective action.  Includes companies, institutions,
# corporations, departments, community groups, healthcare
# practice groups, etc.
class Fhir::Organization < Fhir::Resource
  # Additional Content defined by implementations
  attribute :extension, Array[Extension]

  # Text summary of the resource, for human interpretation
  attribute :text, Narrative

  # Contained, inline Resources
  attribute :contained, Array[ResourceLink[Resource]]

  # Identifier for this organization
  attribute :identifier, Array[Identifier]

  # Name used for the organization
  attribute :name, string

  # Kind of organization
  attribute :type, CodeableConcept

  # A contact detail for the organization
  attribute :telecom, Array[Contact]

  # An address for the organization
  attribute :address, Array[Address]

  # The organization of which this organization forms a part
  attribute :part_of, ResourceLink[Organization]

  # Contact for the organization for a certain purpose.
  class Contact < Fhir::ValueObject
    # The type of contact
    attribute :purpose, CodeableConcept

    # A name associated with the contact
    attribute :name, HumanName

    # Contact details (telephone, email, etc)  for a contact
    attribute :telecom, Array[Contact]

    # Visiting or postal addresses for the contact
    attribute :address, Address

    # Gender for administrative purposes
    attribute :gender, CodeableConcept
  end

  attribute :contact, Array[Contact]

  # Whether the organization's record is still in active use
  attribute :active, boolean
end

