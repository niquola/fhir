class Order
  include Virtus
  # Additional Content defined by implementations
  attribute :extension, Extension

  # Text summary of the resource, for human interpretation
  attribute :text, Narrative

  # Contained, inline Resources
  attribute :contained, Resource

  # When the order was made
  attribute :date, DateTime

  # Patient this order is about
  attribute :subject, Resource(Patient)

  # Who initiated the order
  attribute :source, Resource(Practitioner)

  # Who is intended to fulfill the order
  attribute :target, Resource(Organization|Device)

  # Text - why the order was made
  attribute :reason, String

  # If required by policy
  attribute :authority, Resource(Any)

  # When order should be fulfilled
  attribute :when, When

  class When
    include Virtus::ValueObject
    # Code specifies when request should be done. The code may simply be a priority code
    attribute :code, CodeableConcept

    # A formal schedule
    attribute :schedule, Schedule

  end
  # What action is being ordered
  attribute :detail, Resource(Any)

end
