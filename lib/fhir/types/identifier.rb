# A technical identifier - identifies some entity uniquely
# and unambiguously.
class Fhir::Identifier < Fhir::DataType
  # usual | official | temp | secondary (If known)
  attribute :use, Fhir::Code

  # Description of identifier
  attribute :label, String

  # The namespace for the identifier
  attribute :system, Fhir::URI

  # The value that is unique
  attribute :value, String

  # Time period when id was valid for use
  attribute :period, Fhir::Period

  # Organization that issued id (may be just text)
  resource_reference :assigner, [Fhir::Organization]
end

Fhir.load_extension('identifier')
