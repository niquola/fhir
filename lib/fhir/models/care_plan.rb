class CarePlan
  attribute :extension, Extension
  attribute :text, Narrative
  attribute :contained, Resource
  attribute :identifier, Identifier
  attribute :patient, Resource(Patient)
  attribute :status, code
  attribute :period, Period
  attribute :modified, DateTime
  attribute :concern, Resource(Condition)
  attribute :participant, Participant
  class Participant
    attribute :role, CodeableConcept
    attribute :member, Resource(Practitioner|RelatedPerson|Patient|Organization)
  end
  attribute :goal, Goal
  class Goal
    attribute :description, String
    attribute :status, code
    attribute :notes, String
  end
  attribute :activity, Activity
  class Activity
    attribute :category, code
    attribute :code, CodeableConcept
    attribute :status, code
    attribute :prohibited, boolean
    attribute :timing[x], Schedule
    attribute :location, Resource(Location)
    attribute :performer, Resource(Practitioner|Organization|RelatedPerson|Patient)
    attribute :product, Resource(Medication|Substance)
    attribute :dailyAmount, Quantity
    attribute :quantity, Quantity
    attribute :details, String
    attribute :actionTaken, Resource(Any)
    attribute :notes, String
  end
  attribute :notes, String
end
