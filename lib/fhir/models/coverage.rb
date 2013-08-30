# Financial instrument by which payment information for
# health care.
class Fhir::Coverage < Fhir::Resource
  # Additional Content defined by implementations
  attribute :extension, Array[Fhir::Extension] # Extension

  # Text summary of the resource, for human interpretation
  attribute :text, Fhir::Narrative # Narrative

  # Contained, inline Resources
  attribute :contained, Array[Fhir::Resource] # Resource

  # An identifier for the plan issuer
  attribute :issuer, Fhir::ResourceReference[Fhir::Organization] # Resource(Organization)

  # Coverage start and end dates
  attribute :period, Fhir::Period # Period

  # Type of coverage
  # Should be present
  attribute :type, Fhir::Coding # Coding

  # The primary coverage ID
  attribute :identifier, Fhir::Identifier # Identifier

  # An identifier for the group
  attribute :group, Fhir::Identifier # Identifier

  # An identifier for the plan
  attribute :plan, Fhir::Identifier # Identifier

  # An identifier for the subsection of the plan
  attribute :subplan, Fhir::Identifier # Identifier

  # The dependent number
  attribute :dependent, Integer # integer

  # The plan instance or sequence counter
  attribute :sequence, Integer # integer

  # Planholder information.
  class Subscriber < Fhir::ValueObject
    # PolicyHolder name
    attribute :name, Fhir::HumanName # HumanName

    # PolicyHolder address
    attribute :address, Fhir::Address # Address

    # PolicyHolder date of birth
    attribute :birthdate, Date # date
  end

  attribute :subscriber, Subscriber # 
end

