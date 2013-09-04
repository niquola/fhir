# A request to perform an action.
class Fhir::Order < Fhir::Resource
  # When the order was made
  attribute :date, DateTime

  # Patient this order is about
  resource_reference :subject, [Fhir::Patient]

  # Who initiated the order
  resource_reference :source, [Fhir::Practitioner]

  # Who is intended to fulfill the order
  resource_reference :target, [Fhir::Organization, Fhir::Device]

  # Text - why the order was made
  attribute :reason, String

  # If required by policy
  resource_reference :authority, [Fhir::Resource]

  # When order should be fulfilled.
  class When < Fhir::ValueObject
    # Code specifies when request should be done. The code may
    # simply be a priority code
    attribute :code, Fhir::CodeableConcept

    # A formal schedule
    attribute :schedule, Fhir::Schedule
  end

  attribute :when, When

  # What action is being ordered
  # Should be present
  resource_references :details, [Fhir::Resource]
end

