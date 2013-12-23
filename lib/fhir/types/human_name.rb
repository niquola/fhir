# A human's name with the ability to identify parts and
# usage.
class Fhir::HumanName < Fhir::DataType
  # usual | official | temp | nickname | anonymous | old |
  # maiden
  attribute :use, Fhir::Code

  # Text representation of the full name
  attribute :text, String

  # Family name (often called 'Surname')
  attribute :family, Array[String]

  # Given names (not always 'first'). Includes middle names
  attribute :given, Array[String]

  # Parts that come before the name
  attribute :prefix, Array[String]

  # Parts that come after the name
  attribute :suffix, Array[String]

  # Time period when name was/is in use
  attribute :period, Fhir::Period
end

Fhir.load_extension('human_name')
