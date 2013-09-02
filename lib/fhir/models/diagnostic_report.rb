# The findings and interpretation of diagnostic  tests
# performed on patients and/or specimens. The report includes
# clinical context such as requesting and provider
# information, and some mix of atomic results, images, textual
# and coded interpretation, and formatted representation of
# diagnostic reports.
class Fhir::DiagnosticReport < Fhir::Resource
  # Additional Content defined by implementations
  attribute :extensions, Array[Fhir::Extension] # Extension

  # Text summary of the resource, for human interpretation
  attribute :text, Fhir::Narrative # Narrative

  # Contained, inline Resources
  attribute :containeds, Array[Fhir::Resource] # Resource

  # registered|interim|final|amended|cancelled|withdrawn
  # Should be present
  attribute :status, Fhir::Code # code

  # Date this version was released
  # Should be present
  attribute :issued, DateTime # dateTime

  # The subject of the report
  # Should be present
  attribute :subject, Fhir::ResourceReference[Fhir::Patient, Fhir::Group, Fhir::Device] # Resource(Patient|Group|Device)

  # Responsible Diagnostic Service
  # Should be present
  attribute :performer, Fhir::ResourceReference[Fhir::Organization] # Resource(Organization)

  # Id for external references to this report
  attribute :report_id, Fhir::Identifier # Identifier

  # Details concerning a single pathology test requested.
  class RequestDetail < Fhir::ValueObject
    # Context where request was made
    attribute :encounter, Fhir::ResourceReference[Fhir::Encounter] # Resource(Encounter)

    # Id assigned by requester
    attribute :request_order_id, Fhir::Identifier # Identifier

    # Receiver's Id for the request
    attribute :receiver_order_id, Fhir::Identifier # Identifier

    # Test Requested
    attribute :request_tests, Array[Fhir::CodeableConcept] # CodeableConcept

    # Location of requested test (if applicable)
    attribute :body_site, Fhir::CodeableConcept # CodeableConcept

    # Responsible for request
    attribute :requester, Fhir::ResourceReference[Fhir::Organization, Fhir::Practitioner] # Resource(Organization|Practitioner)

    # Clinical information provided
    attribute :clinical_info, String # string
  end

  attribute :request_details, Array[RequestDetail] # 

  # Biochemistry, Haematology etc.
  attribute :service_category, Fhir::CodeableConcept # CodeableConcept

  # Effective time of diagnostic report
  # Should be present
  attribute :diagnostic_time, DateTime # dateTime

  # A group of results. Results may be grouped by specimen, or
  # by some value in DiagnosticReport.resultGroup.name to
  # describe what binds all the results together.
  class Results < Fhir::ValueObject
    # Name/Code for this group of results
    # Should be present
    attribute :name, Fhir::CodeableConcept # CodeableConcept

    # Specimen details for this group
    attribute :specimen, Fhir::ResourceReference[Fhir::Specimen] # Resource(Specimen)

    # Nested Report Group
    attribute :groups, Array[Fhir::DiagnosticReport::Results] # @DiagnosticReport.results

    # An atomic data result
    attribute :results, Array[Fhir::ResourceReference[Fhir::Observation]] # Resource(Observation)
  end

  # Should be present
  attribute :results, Results # 

  # Key images associated with this report
  attribute :images, Array[Fhir::ResourceReference[Fhir::Media, Fhir::ImagingStudy]] # Resource(Media|ImagingStudy)

  # Clinical Interpretation of test results
  attribute :conclusion, String # string

  # Codes for the conclusion
  attribute :coded_diagnoses, Array[Fhir::CodeableConcept] # CodeableConcept

  # Entire Report as issued
  attribute :representations, Array[Fhir::Attachment] # Attachment
end

