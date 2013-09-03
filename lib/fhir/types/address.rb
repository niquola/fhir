# There is a variety of postal address formats defined
# around the world. This format defines a superset that is the
# basis for addresses all around the world.
class Fhir::Address < Fhir::Type
  # The use of this address
  attribute :use, Fhir::Code # code

  # Line of an address
  attribute :lines, Array[String] # string

  # Name of city, town etc.
  attribute :city, String # string

  # Sub-unit of country (abreviations ok)
  attribute :state, String # string

  # Post code for area
  attribute :zip, String # string

  # Country (can be ISO 3166 3 letter code)
  attribute :country, String # string

  # Time period when address was/is in use
  attribute :period, Fhir::Period # Period
end

