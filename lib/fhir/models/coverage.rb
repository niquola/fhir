# Financial instrument by which payment information for
# health care.
class Fhir::Coverage < Fhir::Resource
  invariants do
    validates_presence_of :type
  end

  # Text summary of the resource, for human interpretation
  attribute :text, Fhir::Narrative

  # An identifier for the plan issuer
  resource_reference :issuer, [Fhir::Organization]

  # Coverage start and end dates
  attribute :period, Fhir::Period

  # Type of coverage
  # Should be present
  attribute :type, Fhir::Coding

  # The primary coverage ID
  attribute :identifier, Fhir::Identifier

  # An identifier for the group
  attribute :group, Fhir::Identifier

  # An identifier for the plan
  attribute :plan, Fhir::Identifier

  # An identifier for the subsection of the plan
  attribute :subplan, Fhir::Identifier

  # The dependent number
  attribute :dependent, Integer

  # The plan instance or sequence counter
  attribute :sequence, Integer

  # Planholder information.
  class Subscriber < Fhir::ValueObject
    # PolicyHolder name
    attribute :name, Fhir::HumanName

    # PolicyHolder address
    attribute :address, Fhir::Address

    # PolicyHolder date of birth
    attribute :birthdate, Date
  end

  attribute :subscriber, Subscriber
end

