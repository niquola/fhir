# A formally or informally recognized grouping of people or
# organizations formed for the purpose of achieving some form
# of collective action.  Includes companies, institutions,
# corporations, departments, community groups, healthcare
# practice groups, etc.
class Fhir::Organization < Fhir::Resource
  # Additional Content defined by implementations
  attribute :extension, Array[Fhir::Extension] # Extension

  # Text summary of the resource, for human interpretation
  attribute :text, Fhir::Narrative # Narrative

  # Contained, inline Resources
  attribute :contained, Array[Fhir::Resource] # Resource

  # Identifier for this organization
  attribute :identifier, Array[Fhir::Identifier] # Identifier

  # Name used for the organization
  attribute :name, String # string

  # Kind of organization
  attribute :type, Fhir::CodeableConcept # CodeableConcept

  # A contact detail for the organization
  attribute :telecom, Array[Fhir::Contact] # Contact

  # An address for the organization
  attribute :address, Array[Fhir::Address] # Address

  # The organization of which this organization forms a part
  attribute :part_of, Fhir::ResourceReference[Fhir::Organization] # Resource(Organization)

  # Contact for the organization for a certain purpose.
  class Contact < Fhir::ValueObject
    # The type of contact
    attribute :purpose, Fhir::CodeableConcept # CodeableConcept

    # A name associated with the contact
    attribute :name, Fhir::HumanName # HumanName

    # Contact details (telephone, email, etc)  for a contact
    attribute :telecom, Array[Fhir::Contact] # Contact

    # Visiting or postal addresses for the contact
    attribute :address, Fhir::Address # Address

    # Gender for administrative purposes
    attribute :gender, Fhir::CodeableConcept # CodeableConcept
  end

  attribute :contact, Array[Contact] # 

  # Whether the organization's record is still in active use
  attribute :active, Boolean # boolean
end

