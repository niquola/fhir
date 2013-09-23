# A formally or informally recognized grouping of people or
# organizations formed for the purpose of achieving some form
# of collective action.  Includes companies, institutions,
# corporations, departments, community groups, healthcare
# practice groups, etc.
class Fhir::Organization < Fhir::Resource
  # Text summary of the resource, for human interpretation
  attribute :text, Fhir::Narrative

  # Identifier for this organization
  attribute :identifiers, Array[Fhir::Identifier]

  # Name used for the organization
  attribute :name, String

  # Kind of organization
  attribute :type, Fhir::CodeableConcept

  # A contact detail for the organization
  attribute :telecoms, Array[Fhir::Contact]

  # An address for the organization
  attribute :addresses, Array[Fhir::Address]

  # The organization of which this organization forms a part
  resource_reference :part_of, [Fhir::Organization]

  # Contact for the organization for a certain purpose.
  class Contact < Fhir::ValueObject
    # The type of contact
    attribute :purpose, Fhir::CodeableConcept

    # A name associated with the contact
    attribute :name, Fhir::HumanName

    # Contact details (telephone, email, etc)  for a contact
    attribute :telecoms, Array[Fhir::Contact]

    # Visiting or postal addresses for the contact
    attribute :address, Fhir::Address

    # Gender for administrative purposes
    attribute :gender, Fhir::CodeableConcept
  end

  attribute :contacts, Array[Contact]

  # Whether the organization's record is still in active use
  attribute :active, Boolean
end


Fhir.load_handmade('organization')
