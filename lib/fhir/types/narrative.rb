class Fhir::Narrative < Fhir::Type
  attribute :statuses, Array[Fhir::Code]
  attribute :divs, Array[Fhir::xhtml]
end
