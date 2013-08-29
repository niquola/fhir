class Other
  include Virtus
  # Additional Content defined by implementations
  attribute :extension, Extension

  # Text summary of the resource, for human interpretation
  attribute :text, Narrative

  # Contained, inline Resources
  attribute :contained, Resource

  # Kind of Resource
  attribute :code, CodeableConcept

  # Identifies the
  attribute :subject, Resource(Any)

  # Who created
  attribute :author, Resource(Practitioner|Patient|RelatedPerson)

  # When created
  attribute :created, date

end
