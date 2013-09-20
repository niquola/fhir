class Fhir::Patient
  attribute :medical_record_number, String
  attribute :ethnicity, Fhir::CodeableConcept
  attribute :races, Array[Fhir::CodeableConcept]
end
