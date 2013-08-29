class Media
  include Virtus
  # Additional Content defined by implementations
  attribute :extension, Extension

  # Text summary of the resource, for human interpretation
  attribute :text, Narrative

  # Contained, inline Resources
  attribute :contained, Resource

  # photo | audio | video
  attribute :type, code

  # The type of acquisition equipment/process
  attribute :subtype, CodeableConcept

  # Identifier(s) for the image
  attribute :identifier, Identifier

  # When the media was taken/recorded
  attribute :dateTime, DateTime

  # Who/What this Media is a record of
  attribute :subject, Resource(Patient|Practitioner|Group|Device|Specimen)

  # Who asked that this image be collected
  attribute :requester, Resource(Practitioner)

  # The person who generated the image
  attribute :operator, Resource(Practitioner)

  # Imaging view e.g Lateral or Antero-posterior
  attribute :view, CodeableConcept

  # Name of the device/manufacturer
  attribute :deviceName, String

  # Height of the image in pixels(photo/video)
  attribute :height, integer

  # Width of the image in pixels (photo/video)
  attribute :width, integer

  # Number of frames if > 1 (photo)
  attribute :frames, integer

  # Length in seconds (audio / video)
  attribute :length, integer

  # Actual Media - reference or data
  attribute :content, Attachment

end
