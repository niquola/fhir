# Optional Extensions Element - found in all resources.
class Fhir::Extension < Fhir::DataType
  invariants do
    validates_presence_of :url
  end

  # identifies the meaning of the extension
  attribute :url, Fhir::URI

  # Value of extension
  attribute :value, Object
end

Fhir.load_extension('extension')
