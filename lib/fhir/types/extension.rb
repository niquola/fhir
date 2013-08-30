# Optional Extensions Element - found in all resources.
class Fhir::Extension < Fhir::Type
  # identifies the meaning of the extension
  # Should be present
  attribute :url, Fhir::URI # uri

  # If extension modifies other elements/extensions
  attribute :is_modifier, Boolean # boolean

  # Value of extension
  attribute :value, Object # *
end

