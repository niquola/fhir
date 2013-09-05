# Optional Extensions Element - found in all resources.
class Fhir::Extension < Fhir::DataType
  # identifies the meaning of the extension
  # Should be present
  attribute :url, Fhir::URI

  # If extension modifies other elements/extensions
  attribute :is_modifier, Boolean

  # Value of extension
  attribute :value, Object
end

