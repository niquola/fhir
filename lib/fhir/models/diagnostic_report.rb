class DiagnosticReport
  attribute :extension, Extension
  attribute :text, Narrative
  attribute :contained, Resource
  attribute :status, code
  attribute :issued, DateTime
  attribute :subject, Resource(Patient|Group|Device)
  attribute :performer, Resource(Organization)
  attribute :reportId, Identifier
  attribute :requestDetail, RequestDetail
  class RequestDetail
    attribute :encounter, Resource(Encounter)
    attribute :requestOrderId, Identifier
    attribute :receiverOrderId, Identifier
    attribute :requestTest, CodeableConcept
    attribute :bodySite, CodeableConcept
    attribute :requester, Resource(Organization|Practitioner)
    attribute :clinicalInfo, String
  end
  attribute :serviceCategory, CodeableConcept
  attribute :diagnosticTime, DateTime
  attribute :results, Results
  class Results
    attribute :name, CodeableConcept
    attribute :specimen, Resource(Specimen)
    attribute :group, @DiagnosticReport.results
    attribute :result, Resource(Observation)
  end
  attribute :image, Resource(Media|ImagingStudy)
  attribute :conclusion, String
  attribute :codedDiagnosis, CodeableConcept
  attribute :representation, Attachment
end
