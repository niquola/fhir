# A photo, video, or audio recording acquired or used in
# healthcare. The actual content maybe inline or provided by
# direct reference.
class Fhir::Media < Fhir::Resource
  # photo | audio | video
  # Should be present
  attribute :type, Fhir::Code # code

  # The type of acquisition equipment/process
  attribute :subtype, Fhir::CodeableConcept # CodeableConcept

  # Identifier(s) for the image
  attribute :identifiers, Array[Fhir::Identifier] # Identifier

  # When the media was taken/recorded
  attribute :date_time, DateTime # dateTime

  # Who/What this Media is a record of
  resource_reference :subject, [Fhir::Patient, Fhir::Practitioner, Fhir::Group, Fhir::Device, Fhir::Specimen]

  # Who asked that this image be collected
  resource_reference :requester, [Fhir::Practitioner]

  # The person who generated the image
  resource_reference :operator, [Fhir::Practitioner]

  # Imaging view e.g Lateral or Antero-posterior
  attribute :view, Fhir::CodeableConcept # CodeableConcept

  # Name of the device/manufacturer
  attribute :device_name, String # string

  # Height of the image in pixels(photo/video)
  attribute :height, Integer # integer

  # Width of the image in pixels (photo/video)
  attribute :width, Integer # integer

  # Number of frames if > 1 (photo)
  attribute :frames, Integer # integer

  # Length in seconds (audio / video)
  attribute :length, Integer # integer

  # Actual Media - reference or data
  # Should be present
  attribute :content, Fhir::Attachment # Attachment
end

