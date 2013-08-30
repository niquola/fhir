# A request to perform an action.
class Fhir::Order < Fhir::Resource
  # Additional Content defined by implementations
  attribute :extension, Array[Fhir::Extension] # Extension

  # Text summary of the resource, for human interpretation
  attribute :text, Fhir::Narrative # Narrative

  # Contained, inline Resources
  attribute :contained, Array[Fhir::Resource] # Resource

  # When the order was made
  attribute :date, DateTime # dateTime

  # Patient this order is about
  attribute :subject, Fhir::ResourceReference[Fhir::Patient] # Resource(Patient)

  # Who initiated the order
  attribute :source, Fhir::ResourceReference[Fhir::Practitioner] # Resource(Practitioner)

  # Who is intended to fulfill the order
  attribute :target, Fhir::ResourceReference[Fhir::Organization, Fhir::Device] # Resource(Organization|Device)

  # Text - why the order was made
  attribute :reason, String # string

  # If required by policy
  attribute :authority, Fhir::ResourceReference # Resource(Any)

  # When order should be fulfilled.
  class When < Fhir::ValueObject
    # Code specifies when request should be done. The code may
    # simply be a priority code
    attribute :code, Fhir::CodeableConcept # CodeableConcept

    # A formal schedule
    attribute :schedule, Fhir::Schedule # Schedule
  end

  attribute :when, When # 

  # What action is being ordered
  # Should be present
  attribute :detail, Array[Fhir::ResourceReference] # Resource(Any)
end

