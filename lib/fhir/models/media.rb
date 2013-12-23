# A photo, video, or audio recording acquired or used in
# healthcare. The actual content maybe inline or provided by
# direct reference.
class Fhir::Media < Fhir::Resource
  invariants do
    validates_presence_of :type
    validates_presence_of :content
  end

  # Extensions that cannot be ignored
  attribute :modifier_extension, Array[Fhir::Extension]

  # Text summary of the resource, for human interpretation
  attribute :text, Fhir::Narrative

  # photo | video | audio
  attribute :type, Fhir::Code

  # The type of acquisition equipment/process
  attribute :subtype, Fhir::CodeableConcept

  # Identifier(s) for the image
  attribute :identifier, Array[Fhir::Identifier]

  # When the media was taken/recorded (end)
  attribute :date_time, DateTime

  # Who/What this Media is a record of
  resource_reference :subject, [Fhir::Patient, Fhir::Practitioner, Fhir::Group, Fhir::Device, Fhir::Specimen]

  # The person who generated the image
  resource_reference :operator, [Fhir::Practitioner]

  # Imaging view e.g Lateral or Antero-posterior
  attribute :view, Fhir::CodeableConcept

  # Name of the device/manufacturer
  attribute :device_name, String

  # Height of the image in pixels(photo/video)
  attribute :height, Integer

  # Width of the image in pixels (photo/video)
  attribute :width, Integer

  # Number of frames if > 1 (photo)
  attribute :frames, Integer

  # Length in seconds (audio / video)
  attribute :length, Integer

  # Actual Media - reference or data
  attribute :content, Fhir::Attachment
end


Fhir.load_extension('media')
