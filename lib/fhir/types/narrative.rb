# A human readable formatted text, including images.
class Fhir::Narrative < Fhir::DataType
  invariants do
    validates_presence_of :status
    validates_presence_of :div
  end

  # generated | extensions | additional
  # Should be present
  attribute :status, Fhir::Code

  # Limited xhtml content
  # Should be present
  attribute :div, String
end

