class RelatedPerson
  attribute :extension, Extension
  attribute :text, Narrative
  attribute :contained, Resource
  attribute :identifier, Identifier
  attribute :patient, Resource(Patient)
  attribute :relationship, CodeableConcept
  attribute :name, HumanName
  attribute :telecom, Contact
  attribute :gender, CodeableConcept
  attribute :address, Address
  attribute :photo, Attachment
end
