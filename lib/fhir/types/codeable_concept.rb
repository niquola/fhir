class Fhir::CodeableConcept < Fhir::Type
  attribute :coding, Fhir::Coding
  attribute :texts, Array[String]
  attribute :primaries, Array[Fhir::idref]
end
