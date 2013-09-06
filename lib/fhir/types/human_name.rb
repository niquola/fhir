# A human's name with the ability to identify parts and
# usage.
class Fhir::HumanName < Fhir::DataType
  # The use of this name
  attribute :use, Fhir::Code

  # Text representation of the full name
  attribute :text, String

  # Family name (often called 'Surname')
  attribute :families, Array[String]

  # Given names (not always 'first'). Includes middle names
  attribute :givens, Array[String]

  # Parts that come before the name
  attribute :prefixes, Array[String]

  # Parts that come after the name
  attribute :suffixes, Array[String]

  # Time period when name was/is in use
  attribute :period, Fhir::Period
end

