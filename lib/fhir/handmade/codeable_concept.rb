# A concept that may be defined by a formal reference to a
# terminology or ontology or may be provided by text.
class Fhir::CodeableConcept < Fhir::DataType
  # Code defined by a terminology system
  attribute :codings, Array[Fhir::Coding]

  # Plain text representation of the concept
  attribute :text, String

  # Which code was chosen directly by the user
  #attribute :primary, Integer

  def find_by_system(coding_system)
    codings.select { |c| c.system == coding_system }.first
  end

  def primary
    codings.first
  end
end

