# A measured amount (or an amount that can potentially be
# measured). Note that measured amounts include amounts that
# are not precisely quantified, including amounts involving
# arbitrary units and floating currencies.
class Fhir::Quantity < Fhir::DataType
  # Numerical value (with implicit precision)
  attribute :value, Float

  # < | <= | >= | > - how to understand the value
  attribute :comparator, Fhir::Code

  # Unit representation
  attribute :units, String

  # System that defines coded unit form
  attribute :system, Fhir::URI

  # Coded form of the unit
  attribute :code, Fhir::Code
end

Fhir.load_extension('quantity')
