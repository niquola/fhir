# A measured amount (or an amount that can potentially be
# measured). Note that measured amounts include amounts that
# are not precisely quantified, including amounts involving
# arbitrary units and floating currencies.
class Fhir::Quantity < Fhir::Type
  # Numerical value (with implicit precision)
  attribute :value, Float # decimal

  # Relationship of stated value to actual value
  attribute :comparator, Fhir::Code # code

  # Unit representation
  attribute :units, String # string

  # System that defines coded unit form
  attribute :system, Fhir::URI # uri

  # Coded form of the unit
  attribute :code, Fhir::Code # code
end

