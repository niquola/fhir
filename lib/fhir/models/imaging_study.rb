class ImagingStudy
  include Virtus
  # Additional Content defined by implementations
  attribute :extension, Extension

  # Text summary of the resource, for human interpretation
  attribute :text, Narrative

  # Contained, inline Resources
  attribute :contained, Resource

  # When the study was performed
  attribute :dateTime, DateTime

  # Who the images are of
  attribute :subject, Resource(Patient)

  # Formal identifier for the study (0020,000D)
  attribute :uid, oid

  # Accession Number (0008,0050)
  attribute :accessionNo, Identifier

  # Other identifiers for the study (0020,0010)
  attribute :identifier, Identifier

  # All series.modality if actual acquisition modalities
  attribute :modality, code

  # Referring physician (0008,0090)
  attribute :referrer, Resource(Practitioner)

  # Instance Availability (0008,0056)
  attribute :availability, code

  # Retrieve URI (0040,E010)
  attribute :url, uri

  # Number of Study Related Series (0020,1206)
  attribute :numberOfSeries, integer

  # Number of Study Related Instances (0020,1208)
  attribute :numberOfInstances, integer

  # Diagnoses etc with request (0008,1080)
  attribute :clinicalInformation, String

  # Type of procedure performed (0008,1032)
  attribute :procedure, Coding

  # Who interpreted images (0008,1060)
  attribute :interpreter, Resource(Practitioner)

  # Institution-generated description (0008,1030)
  attribute :description, String

  # Each study has one or more series of instances
  attribute :series, Series

  class Series
    include Virtus::ValueObject
    # Number of this series in overall sequence (0020,0011)
    attribute :number, integer

    # The modality of this sequence (0008,0060)
    attribute :modality, code

    # Formal identifier for this series (0020,000E)
    attribute :uid, oid

    # A description of the series (0008,103E)
    attribute :description, String

    # Number of Series Related Instances (0020,1209)
    attribute :numberOfInstances, integer

    # Instance Availability (0008,0056)
    attribute :availability, code

    # Retrieve URI (0040,E010)
    attribute :url, uri

    # Body part examined (Map from 0018,0015)
    attribute :bodySite, Coding

    # When the series started
    attribute :dateTime, DateTime

    # A single instance taken from a patient (image or other)
    attribute :instance, Instance

    class Instance
      include Virtus::ValueObject
      # The number of this instance in the series (0020,0013)
      attribute :number, integer

      # Formal identifier for this instance (0008,0018)
      attribute :uid, oid

      # DICOM class type (0008,0016)
      attribute :sopclass, oid

      # Type of instance (0004,1430)
      attribute :type, String

      # Description to be provided
      attribute :title, String

      # WADO / WADO-RS service where instance is available
      attribute :url, uri

      # A FHIR resource with content for this instance
      attribute :attachment, Resource(Any)

    end
  end
end
