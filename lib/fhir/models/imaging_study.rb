# Manifest of a set of images produced in study. The set of
# images may include every image in the study, or it may be an
# incomplete sample, such as a list of key images.
class Fhir::ImagingStudy < Fhir::Resource
  # Additional Content defined by implementations
  attribute :extension, Array[Extension]

  # Text summary of the resource, for human interpretation
  attribute :text, Narrative

  # Contained, inline Resources
  attribute :contained, Array[ResourceLink[Resource]]

  # When the study was performed
  attribute :date_time, dateTime

  # Who the images are of
  # Should be present
  attribute :subject, ResourceLink[Patient]

  # Formal identifier for the study (0020,000D)
  # Should be present
  attribute :uid, oid

  # Accession Number (0008,0050)
  attribute :accession_no, Identifier

  # Other identifiers for the study (0020,0010)
  attribute :identifier, Array[Identifier]

  # All series.modality if actual acquisition modalities
  attribute :modality, Array[code]

  # Referring physician (0008,0090)
  attribute :referrer, ResourceLink[Practitioner]

  # Instance Availability (0008,0056)
  attribute :availability, code

  # Retrieve URI (0040,E010)
  attribute :url, uri

  # Number of Study Related Series (0020,1206)
  # Should be present
  attribute :number_of_series, integer

  # Number of Study Related Instances (0020,1208)
  # Should be present
  attribute :number_of_instances, integer

  # Diagnoses etc with request (0008,1080)
  attribute :clinical_information, string

  # Type of procedure performed (0008,1032)
  attribute :procedure, Array[Coding]

  # Who interpreted images (0008,1060)
  attribute :interpreter, ResourceLink[Practitioner]

  # Institution-generated description (0008,1030)
  attribute :description, string

  # Each study has one or more series of image instances.
  class Series < Fhir::ValueObject
    # Number of this series in overall sequence (0020,0011)
    attribute :number, integer

    # The modality of this sequence (0008,0060)
    # Should be present
    attribute :modality, code

    # Formal identifier for this series (0020,000E)
    # Should be present
    attribute :uid, oid

    # A description of the series (0008,103E)
    attribute :description, string

    # Number of Series Related Instances (0020,1209)
    # Should be present
    attribute :number_of_instances, integer

    # Instance Availability (0008,0056)
    attribute :availability, code

    # Retrieve URI (0040,E010)
    attribute :url, uri

    # Body part examined (Map from 0018,0015)
    attribute :body_site, Coding

    # When the series started
    attribute :date_time, dateTime

    # A single image taken from a patient.
    class Instance < Fhir::ValueObject
      # The number of this instance in the series (0020,0013)
      attribute :number, integer

      # Formal identifier for this instance (0008,0018)
      # Should be present
      attribute :uid, oid

      # DICOM class type (0008,0016)
      # Should be present
      attribute :sopclass, oid

      # Type of instance (0004,1430)
      attribute :type, string

      # Description to be provided
      attribute :title, string

      # WADO / WADO-RS service where instance is available
      attribute :url, uri

      # A FHIR resource with content for this instance
      attribute :attachment, ResourceLink[Any]
    end

    # Should be present
    attribute :instance, Array[Instance]
  end

  attribute :series, Array[Series]
end

