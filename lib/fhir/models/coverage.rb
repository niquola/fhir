class Coverage
  attribute :extension, Extension
  attribute :text, Narrative
  attribute :contained, Resource
  attribute :issuer, Resource(Organization)
  attribute :period, Period
  attribute :type, Coding
  attribute :identifier, Identifier
  attribute :group, Identifier
  attribute :plan, Identifier
  attribute :subplan, Identifier
  attribute :dependent, integer
  attribute :sequence, integer
  attribute :subscriber, Subscriber
  class Subscriber
    attribute :name, HumanName
    attribute :address, Address
    attribute :birthdate, date
  end
end
