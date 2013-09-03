# A human's name with the ability to identify parts and
# usage.
class Fhir::HumanName < Fhir::Type
  # The use of this name
  attribute :use, Fhir::Code # code

  # Family name (often called 'Surname')
  attribute :families, Array[String] # string

  # Given names (not always 'first'). Includes middle names
  attribute :givens, Array[String] # string

  # Parts that come before the name
  attribute :prefixes, Array[String] # string

  # Parts that come after the name
  attribute :suffixes, Array[String] # string

  # Time period when name was/is in use
  attribute :period, Fhir::Period # Period
end

