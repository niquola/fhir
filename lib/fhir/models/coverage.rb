# Financial instrument by which payment information for
# health care.
class Fhir::Coverage < Fhir::Resource
  # Additional Content defined by implementations
  attribute :extension, Array[Extension]

  # Text summary of the resource, for human interpretation
  attribute :text, Narrative

  # Contained, inline Resources
  attribute :contained, Array[ResourceLink[Resource]]

  # An identifier for the plan issuer
  attribute :issuer, ResourceLink[Organization]

  # Coverage start and end dates
  attribute :period, Period

  # Type of coverage
  # Should be present
  attribute :type, Coding

  # The primary coverage ID
  attribute :identifier, Identifier

  # An identifier for the group
  attribute :group, Identifier

  # An identifier for the plan
  attribute :plan, Identifier

  # An identifier for the subsection of the plan
  attribute :subplan, Identifier

  # The dependent number
  attribute :dependent, integer

  # The plan instance or sequence counter
  attribute :sequence, integer

  # Planholder information.
  class Subscriber < Fhir::ValueObject
    # PolicyHolder name
    attribute :name, HumanName

    # PolicyHolder address
    attribute :address, Address

    # PolicyHolder date of birth
    attribute :birthdate, date
  end

  attribute :subscriber, Subscriber
end

