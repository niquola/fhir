# A technical identifier - identifies some entity uniquely
# and unambiguously.
class Fhir::Identifier < Fhir::Type
  # The use of this identifier
  attribute :use, Fhir::Code # code

  # Description of identifier
  attribute :label, String # string

  # The namespace for the identifier
  attribute :system, Fhir::URI # uri

  # The value that is unique
  attribute :key, String # string

  # Time period when id was valid for use
  attribute :period, Fhir::Period # Period

  # Organization that issued id (may be just text)
  attribute :assigner, Fhir::ResourceReference[Fhir::Organization] # Resource(Organization)
end

