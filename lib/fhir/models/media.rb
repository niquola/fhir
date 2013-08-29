class Media
  attribute :extension, Extension
  attribute :text, Narrative
  attribute :contained, Resource
  attribute :type, code
  attribute :subtype, CodeableConcept
  attribute :identifier, Identifier
  attribute :dateTime, DateTime
  attribute :subject, Resource(Patient|Practitioner|Group|Device|Specimen)
  attribute :requester, Resource(Practitioner)
  attribute :operator, Resource(Practitioner)
  attribute :view, CodeableConcept
  attribute :deviceName, String
  attribute :height, integer
  attribute :width, integer
  attribute :frames, integer
  attribute :length, integer
  attribute :content, Attachment
end
