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
    validates_presence_of :diagnostic
    validates_presence_of :results
  end

  # Extensions that cannot be ignored
  attribute :modifier_extension, Array[Fhir::Extension]

  # Text summary of the resource, for human interpretation
  attribute :text, Fhir::Narrative

  # registered | partial | final | corrected +
  attribute :status, Fhir::Code

  # Date this version was released
  attribute :issued, DateTime

  # The subject of the report
  resource_reference :subject, [Fhir::Patient, Fhir::Group, Fhir::Device, Fhir::Location]

  # Responsible Diagnostic Service
  resource_reference :performer, [Fhir::Organization]

  # Id for external references to this report
  attribute :report_id, Fhir::Identifier

  # Details concerning a single pathology test requested.
  class RequestDetail < Fhir::ValueObject
    # Extensions that cannot be ignored
    attribute :modifier_extension, Array[Fhir::Extension]

    # Context where request was made
    resource_reference :encounter, [Fhir::Encounter]

    # Id assigned by requester
    attribute :request_order_id, Fhir::Identifier

    # Receiver's Id for the request
    attribute :receiver_order_id, Fhir::Identifier

    # Test Requested
    attribute :request_test, Array[Fhir::CodeableConcept]

    # Location of requested test (if applicable)
    attribute :body_site, Fhir::CodeableConcept

    # Responsible for request
    resource_reference :requester, [Fhir::Organization, Fhir::Practitioner]

    # Clinical information provided
    attribute :clinical_info, String
  end

  attribute :request_detail, Array[RequestDetail]

  # Biochemistry, Haematology etc.
  attribute :service_category, Fhir::CodeableConcept

  # Diagnostically relevant time of diagnostic report
  attribute :diagnostic, *Fhir::Type[DateTime, Fhir::Period]

  # A group of results. Results may be grouped by specimen, or
  # by some value in DiagnosticReport.resultGroup.name to
  # describe what binds all the results together.
  class Results < Fhir::ValueObject
    invariants do
      validates_presence_of :name
    end

    # Extensions that cannot be ignored
    attribute :modifier_extension, Array[Fhir::Extension]

    # Name/Code for this group of results
    attribute :name, Fhir::CodeableConcept

    # Specimen details for this group
    resource_reference :specimen, [Fhir::Specimen]

    # Nested Report Group
    attribute :group, Array[Fhir::DiagnosticReport::Results]

    # An atomic data result
    resource_references :result, [Fhir::Observation]
  end

  attribute :results, Results

  # Key images associated with this report
  resource_references :image, [Fhir::Media, Fhir::ImagingStudy]

  # Clinical Interpretation of test results
  attribute :conclusion, String

  # Codes for the conclusion
  attribute :coded_diagnosis, Array[Fhir::CodeableConcept]

  # Entire Report as issued
  attribute :representation, Array[Fhir::Attachment]
end


Fhir.load_extension('diagnostic_report')
