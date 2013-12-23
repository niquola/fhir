# There is a variety of postal address formats defined
# around the world. This format defines a superset that is the
# basis for addresses all around the world.
class Fhir::Address < Fhir::DataType
  # home | work | temp | old - purpose of this address
  attribute :use, Fhir::Code

  # Text representation of the address
  attribute :text, String

  # Street name, number, direction & P.O. Box etc
  attribute :line, Array[String]

  # Name of city, town etc.
  attribute :city, String

  # Sub-unit of country (abreviations ok)
  attribute :state, String

  # Postal code for area
  attribute :zip, String

  # Country (can be ISO 3166 3 letter code)
  attribute :country, String

  # Time period when address was/is in use
  attribute :period, Fhir::Period
end

Fhir.load_extension('address')
