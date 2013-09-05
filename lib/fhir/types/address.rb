# There is a variety of postal address formats defined
# around the world. This format defines a superset that is the
# basis for addresses all around the world.
class Fhir::Address < Fhir::DataType
  # The use of this address
  attribute :use, Fhir::Code

  # Line of an address
  attribute :lines, Array[String]

  # Name of city, town etc.
  attribute :city, String

  # Sub-unit of country (abreviations ok)
  attribute :state, String

  # Post code for area
  attribute :zip, String

  # Country (can be ISO 3166 3 letter code)
  attribute :country, String

  # Time period when address was/is in use
  attribute :period, Fhir::Period
end

