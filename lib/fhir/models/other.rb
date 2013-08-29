class Other
  attribute :extension, Extension
  attribute :text, Narrative
  attribute :contained, Resource
  attribute :code, CodeableConcept
  attribute :subject, Resource(Any)
  attribute :author, Resource(Practitioner|Patient|RelatedPerson)
  attribute :created, date
end
