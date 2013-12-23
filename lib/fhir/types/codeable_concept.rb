# A concept that may be defined by a formal reference to a
# terminology or ontology or may be provided by text.
class Fhir::CodeableConcept < Fhir::DataType
  # Code defined by a terminology system
  attribute :coding, Array[Fhir::Coding]

  # Plain text representation of the concept
  attribute :text, String
end

Fhir.load_extension('codeable_concept')
