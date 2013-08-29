class DiagnosticReport
  include Virtus
  # Additional Content defined by implementations
  attribute :extension, Extension

  # Text summary of the resource, for human interpretation
  attribute :text, Narrative

  # Contained, inline Resources
  attribute :contained, Resource

  # registered|interim|final|amended|cancelled|withdrawn
  attribute :status, code

  # Date this version was released
  attribute :issued, DateTime

  # The subject of the report
  attribute :subject, Resource(Patient|Group|Device)

  # Responsible Diagnostic Service
  attribute :performer, Resource(Organization)

  # Id for external references to this report
  attribute :reportId, Identifier

  # What was requested
  attribute :requestDetail, RequestDetail

  class RequestDetail
    include Virtus::ValueObject
    # Context where request was made
    attribute :encounter, Resource(Encounter)

    # Id assigned by requester
    attribute :requestOrderId, Identifier

    # Receiver's Id for the request
    attribute :receiverOrderId, Identifier

    # Test Requested
    attribute :requestTest, CodeableConcept

    # Location of requested test (if applicable)
    attribute :bodySite, CodeableConcept

    # Responsible for request
    attribute :requester, Resource(Organization|Practitioner)

    # Clinical information provided
    attribute :clinicalInfo, String

  end
  # Biochemistry, Haematology etc.
  attribute :serviceCategory, CodeableConcept

  # Effective time of diagnostic report
  attribute :diagnosticTime, DateTime

  # Results grouped by specimen/kind/category
  attribute :results, Results

  class Results
    include Virtus::ValueObject
    # Name/Code for this group of results
    attribute :name, CodeableConcept

    # Specimen details for this group
    attribute :specimen, Resource(Specimen)

    # Nested Report Group
    attribute :group, @DiagnosticReport.results

    # An atomic data result
    attribute :result, Resource(Observation)

  end
  # Key images associated with this report
  attribute :image, Resource(Media|ImagingStudy)

  # Clinical Interpretation of test results
  attribute :conclusion, String

  # Codes for the conclusion
  attribute :codedDiagnosis, CodeableConcept

  # Entire Report as issued
  attribute :representation, Attachment

end
