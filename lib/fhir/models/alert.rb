class Alert
  attribute :extension, Extension
  attribute :text, Narrative
  attribute :contained, Resource
  attribute :category, CodeableConcept
  attribute :status, code
  attribute :subject, Resource(Patient)
  attribute :author, Resource(Practitioner|Patient|Device)
  attribute :note, String
end
