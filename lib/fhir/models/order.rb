# A request to perform an action.
class Fhir::Order < Fhir::Resource
  # Additional Content defined by implementations
  attribute :extension, Array[Extension]

  # Text summary of the resource, for human interpretation
  attribute :text, Narrative

  # Contained, inline Resources
  attribute :contained, Array[ResourceLink[Resource]]

  # When the order was made
  attribute :date, dateTime

  # Patient this order is about
  attribute :subject, ResourceLink[Patient]

  # Who initiated the order
  attribute :source, ResourceLink[Practitioner]

  # Who is intended to fulfill the order
  attribute :target, ResourceLink[Organization, Device]

  # Text - why the order was made
  attribute :reason, string

  # If required by policy
  attribute :authority, ResourceLink[Any]

  # When order should be fulfilled.
  class When < Fhir::ValueObject
    # Code specifies when request should be done. The code may
    # simply be a priority code
    attribute :code, CodeableConcept

    # A formal schedule
    attribute :schedule, Schedule
  end

  attribute :when, When

  # What action is being ordered
  # Should be present
  attribute :detail, Array[ResourceLink[Any]]
end

