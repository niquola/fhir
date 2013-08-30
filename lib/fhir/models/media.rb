# A photo, video, or audio recording acquired or used in
# healthcare. The actual content maybe inline or provided by
# direct reference.
class Fhir::Media < Fhir::Resource
  # Additional Content defined by implementations
  attribute :extension, Array[Extension]

  # Text summary of the resource, for human interpretation
  attribute :text, Narrative

  # Contained, inline Resources
  attribute :contained, Array[ResourceLink[Resource]]

  # photo | audio | video
  # Should be present
  attribute :type, code

  # The type of acquisition equipment/process
  attribute :subtype, CodeableConcept

  # Identifier(s) for the image
  attribute :identifier, Array[Identifier]

  # When the media was taken/recorded
  attribute :date_time, dateTime

  # Who/What this Media is a record of
  attribute :subject, ResourceLink[Patient, Practitioner, Group, Device, Specimen]

  # Who asked that this image be collected
  attribute :requester, ResourceLink[Practitioner]

  # The person who generated the image
  attribute :operator, ResourceLink[Practitioner]

  # Imaging view e.g Lateral or Antero-posterior
  attribute :view, CodeableConcept

  # Name of the device/manufacturer
  attribute :device_name, string

  # Height of the image in pixels(photo/video)
  attribute :height, integer

  # Width of the image in pixels (photo/video)
  attribute :width, integer

  # Number of frames if > 1 (photo)
  attribute :frames, integer

  # Length in seconds (audio / video)
  attribute :length, integer

  # Actual Media - reference or data
  # Should be present
  attribute :content, Attachment
end

