# The findings and interpretation of diagnostic  tests
# performed on patients and/or specimens. The report includes
# clinical context such as requesting and provider
# information, and some mix of atomic results, images, textual
# and coded interpretation, and formatted representation of
# diagnostic reports.
class Fhir::DiagnosticReport < Fhir::Resource
  # Additional Content defined by implementations
  attribute :extension, Array[Extension]

  # Text summary of the resource, for human interpretation
  attribute :text, Narrative

  # Contained, inline Resources
  attribute :contained, Array[ResourceLink[Resource]]

  # registered|interim|final|amended|cancelled|withdrawn
  # Should be present
  attribute :status, code

  # Date this version was released
  # Should be present
  attribute :issued, dateTime

  # The subject of the report
  # Should be present
  attribute :subject, ResourceLink[Patient, Group, Device]

  # Responsible Diagnostic Service
  # Should be present
  attribute :performer, ResourceLink[Organization]

  # Id for external references to this report
  attribute :report_id, Identifier

  # Details concerning a single pathology test requested.
  class RequestDetail < Fhir::ValueObject
    # Context where request was made
    attribute :encounter, ResourceLink[Encounter]

    # Id assigned by requester
    attribute :request_order_id, Identifier

    # Receiver's Id for the request
    attribute :receiver_order_id, Identifier

    # Test Requested
    attribute :request_test, Array[CodeableConcept]

    # Location of requested test (if applicable)
    attribute :body_site, CodeableConcept

    # Responsible for request
    attribute :requester, ResourceLink[Organization, Practitioner]

    # Clinical information provided
    attribute :clinical_info, string
  end

  attribute :request_detail, Array[RequestDetail]

  # Biochemistry, Haematology etc.
  attribute :service_category, CodeableConcept

  # Effective time of diagnostic report
  # Should be present
  attribute :diagnostic_time, dateTime

  # A group of results. Results may be grouped by specimen, or
  # by some value in DiagnosticReport.resultGroup.name to
  # describe what binds all the results together.
  class Results < Fhir::ValueObject
    # Name/Code for this group of results
    # Should be present
    attribute :name, CodeableConcept

    # Specimen details for this group
    attribute :specimen, ResourceLink[Specimen]

    # Nested Report Group
    attribute :group, Array[@DiagnosticReport.results]

    # An atomic data result
    attribute :result, Array[ResourceLink[Observation]]
  end

  # Should be present
  attribute :results, Results

  # Key images associated with this report
  attribute :image, Array[ResourceLink[Media, ImagingStudy]]

  # Clinical Interpretation of test results
  attribute :conclusion, string

  # Codes for the conclusion
  attribute :coded_diagnosis, Array[CodeableConcept]

  # Entire Report as issued
  attribute :representation, Array[Attachment]
end

