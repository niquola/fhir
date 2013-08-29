class Order
  attribute :extension, Extension
  attribute :text, Narrative
  attribute :contained, Resource
  attribute :date, DateTime
  attribute :subject, Resource(Patient)
  attribute :source, Resource(Practitioner)
  attribute :target, Resource(Organization|Device)
  attribute :reason, String
  attribute :authority, Resource(Any)
  attribute :when, When
  class When
    attribute :code, CodeableConcept
    attribute :schedule, Schedule
  end
  attribute :detail, Resource(Any)
end
