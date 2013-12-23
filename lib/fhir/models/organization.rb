# A formally or informally recognized grouping of people or
# organizations formed for the purpose of achieving some form
# of collective action.  Includes companies, institutions,
# corporations, departments, community groups, healthcare
# practice groups, etc.
class Fhir::Organization < Fhir::Resource
  # Extensions that cannot be ignored
  attribute :modifier_extension, Array[Fhir::Extension]

  # Text summary of the resource, for human interpretation
  attribute :text, Fhir::Narrative

  # Identifies this organization  across multiple systems
  attribute :identifier, Array[Fhir::Identifier]

  # Name used for the organization
  attribute :name, String

  # Kind of organization
  attribute :type, Fhir::CodeableConcept

  # A contact detail for the organization
  attribute :telecom, Array[Fhir::Contact]

  # An address for the organization
  attribute :address, Array[Fhir::Address]

  # The organization of which this organization forms a part
  resource_reference :part_of, [Fhir::Organization]

  # Contact for the organization for a certain purpose.
  class Contact < Fhir::ValueObject
    # Extensions that cannot be ignored
    attribute :modifier_extension, Array[Fhir::Extension]

    # The type of contact
    attribute :purpose, Fhir::CodeableConcept

    # A name associated with the contact
    attribute :name, Fhir::HumanName

    # Contact details (telephone, email, etc)  for a contact
    attribute :telecom, Array[Fhir::Contact]

    # Visiting or postal addresses for the contact
    attribute :address, Fhir::Address

    # Gender for administrative purposes
    attribute :gender, Fhir::CodeableConcept
  end

  attribute :contact, Array[Contact]

  # Location(s) the organization uses to provide services
  resource_references :location, [Fhir::Location]

  # Whether the organization's record is still in active use
  attribute :active, Boolean
end


Fhir.load_extension('organization')
