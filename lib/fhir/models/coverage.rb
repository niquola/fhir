# Financial instrument by which payment information for
# health care.
class Fhir::Coverage < Fhir::Resource
  # An identifier for the plan issuer
  resource_reference :issuer, [Fhir::Organization]

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

