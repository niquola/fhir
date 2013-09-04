# Manifest of a set of images produced in study. The set of
# images may include every image in the study, or it may be an
# incomplete sample, such as a list of key images.
class Fhir::ImagingStudy < Fhir::Resource
  # When the study was performed
  attribute :date_time, DateTime

  # Who the images are of
  # Should be present
  resource_reference :subject, [Fhir::Patient]

  # Formal identifier for the study (0020,000D)
  # Should be present
  attribute :uid, String

  # Accession Number (0008,0050)
  attribute :accession_no, Fhir::Identifier

  # Other identifiers for the study (0020,0010)
  attribute :identifiers, Array[Fhir::Identifier]

  # All series.modality if actual acquisition modalities
  attribute :modalities, Array[Fhir::Code]

  # Referring physician (0008,0090)
  resource_reference :referrer, [Fhir::Practitioner]

  # Instance Availability (0008,0056)
  attribute :availability, Fhir::Code

  # Retrieve URI (0040,E010)
  attribute :url, Fhir::URI

  # Number of Study Related Series (0020,1206)
  # Should be present
  attribute :number_of_series, Integer

  # Number of Study Related Instances (0020,1208)
  # Should be present
  attribute :number_of_instances, Integer

  # Diagnoses etc with request (0008,1080)
  attribute :clinical_information, String

  # Type of procedure performed (0008,1032)
  attribute :procedures, Array[Fhir::Coding]

  # Who interpreted images (0008,1060)
  resource_reference :interpreter, [Fhir::Practitioner]

  # Institution-generated description (0008,1030)
  attribute :description, String

  # Each study has one or more series of image instances.
  class Series < Fhir::ValueObject
    # Number of this series in overall sequence (0020,0011)
    attribute :number, Integer

    # The modality of this sequence (0008,0060)
    # Should be present
    attribute :modality, Fhir::Code

    # Formal identifier for this series (0020,000E)
    # Should be present
    attribute :uid, String

    # A description of the series (0008,103E)
    attribute :description, String

    # Number of Series Related Instances (0020,1209)
    # Should be present
    attribute :number_of_instances, Integer

    # Instance Availability (0008,0056)
    attribute :availability, Fhir::Code

    # Retrieve URI (0040,E010)
    attribute :url, Fhir::URI

    # Body part examined (Map from 0018,0015)
    attribute :body_site, Fhir::Coding

    # When the series started
    attribute :date_time, DateTime

    # A single image taken from a patient.
    class Instance < Fhir::ValueObject
      # The number of this instance in the series (0020,0013)
      attribute :number, Integer

      # Formal identifier for this instance (0008,0018)
      # Should be present
      attribute :uid, String

      # DICOM class type (0008,0016)
      # Should be present
      attribute :sopclass, String

      # Type of instance (0004,1430)
      attribute :type, String

      # Description to be provided
      attribute :title, String

      # WADO / WADO-RS service where instance is available
      attribute :url, Fhir::URI

      # A FHIR resource with content for this instance
      resource_reference :attachment, [Fhir::Resource]
    end

    # Should be present
    attribute :instances, Array[Instance]
  end

  attribute :series, Array[Series]
end

