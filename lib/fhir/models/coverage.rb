# Insurance or medical plan
class Coverage
  include Virtus
  # Additional Content defined by implementations
  attribute :extension, Extension

  # Text summary of the resource, for human interpretation
  attribute :text, Narrative

  # Contained, inline Resources
  attribute :contained, Resource

  # An identifier for the plan issuer
  attribute :issuer, Resource(Organization)

  # Coverage start and end dates
  attribute :period, Period

  # Type of coverage
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

  # Planholder information
  attribute :subscriber, Subscriber

  class Subscriber
    include Virtus::ValueObject
    # PolicyHolder name
    attribute :name, HumanName

    # PolicyHolder address
    attribute :address, Address

    # PolicyHolder date of birth
    attribute :birthdate, date

  end
end
