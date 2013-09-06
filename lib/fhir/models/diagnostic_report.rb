# The findings and interpretation of diagnostic  tests
# performed on patients and/or specimens. The report includes
# clinical context such as requesting and provider
# information, and some mix of atomic results, images, textual
# and coded interpretation, and formatted representation of
# diagnostic reports.
class Fhir::DiagnosticReport < Fhir::Resource
  invariants do
    validates_presence_of :status
    validates_presence_of :issued
    validates_presence_of :subject_ref
    validates_presence_of :performer_ref
    validates_presence_of :diagnostic_time
    validates_presence_of :results
  end

  # Text summary of the resource, for human interpretation
  attribute :text, Fhir::Narrative

  # registered|interim|final|amended|cancelled|withdrawn
  attribute :status, Fhir::Code

  # Date this version was released
  attribute :issued, DateTime

  # The subject of the report
  resource_reference :subject, [Fhir::Patient, Fhir::Group, Fhir::Device]

  # Responsible Diagnostic Service
  resource_reference :performer, [Fhir::Organization]

  # Id for external references to this report
  attribute :report_id, Fhir::Identifier

  # Details concerning a single pathology test requested.
  class RequestDetail < Fhir::ValueObject
    # Context where request was made
    resource_reference :encounter, [Fhir::Encounter]

    # Id assigned by requester
    attribute :request_order_id, Fhir::Identifier

    # Receiver's Id for the request
    attribute :receiver_order_id, Fhir::Identifier

    # Test Requested
    attribute :request_tests, Array[Fhir::CodeableConcept]

    # Location of requested test (if applicable)
    attribute :body_site, Fhir::CodeableConcept

    # Responsible for request
    resource_reference :requester, [Fhir::Organization, Fhir::Practitioner]

    # Clinical information provided
    attribute :clinical_info, String
  end

  attribute :request_details, Array[RequestDetail]

  # Biochemistry, Haematology etc.
  attribute :service_category, Fhir::CodeableConcept

  # Effective time of diagnostic report
  attribute :diagnostic_time, DateTime

  # A group of results. Results may be grouped by specimen, or
  # by some value in DiagnosticReport.resultGroup.name to
  # describe what binds all the results together.
  class Results < Fhir::ValueObject
    invariants do
      validates_presence_of :name
    end

    # Name/Code for this group of results
    attribute :name, Fhir::CodeableConcept

    # Specimen details for this group
    resource_reference :specimen, [Fhir::Specimen]

    # Nested Report Group
    attribute :groups, Array[Fhir::DiagnosticReport::Results]

    # An atomic data result
    resource_references :results, [Fhir::Observation]
  end

  attribute :results, Results

  # Key images associated with this report
  resource_references :images, [Fhir::Media, Fhir::ImagingStudy]

  # Clinical Interpretation of test results
  attribute :conclusion, String

  # Codes for the conclusion
  attribute :coded_diagnoses, Array[Fhir::CodeableConcept]

  # Entire Report as issued
  attribute :representations, Array[Fhir::Attachment]
end

