# Healthcare plan for patient
class CarePlan
  include Virtus
  # Additional Content defined by implementations
  attribute :extension, Extension

  # Text summary of the resource, for human interpretation
  attribute :text, Narrative

  # Contained, inline Resources
  attribute :contained, Resource

  # ID for plan
  attribute :identifier, Identifier

  # Who care plan is for
  attribute :patient, Resource(Patient)

  # planned | active | ended
  attribute :status, code

  # Time period plan covers
  attribute :period, Period

  # When last updated
  attribute :modified, DateTime

  # Health issues plan addresses
  attribute :concern, Resource(Condition)

  # Who's involved in plan?
  attribute :participant, Participant

  class Participant
    include Virtus::ValueObject
    # Type of involvement
    attribute :role, CodeableConcept

    # Who is involved
    attribute :member, Resource(Practitioner|RelatedPerson|Patient|Organization)

  end
  # Desired outcome of plan
  attribute :goal, Goal

  class Goal
    include Virtus::ValueObject
    # What's the desired outcome?
    attribute :description, String

    # in progress | achieved | sustaining | abandoned
    attribute :status, code

    # Comments about the goal
    attribute :notes, String

  end
  # Action to occur as part of plan
  attribute :activity, Activity

  class Activity
    include Virtus::ValueObject
    # encounter | procedure | observation | +
    attribute :category, code

    # Detail type of activity
    attribute :code, CodeableConcept

    # not started | ongoing | suspended | completed | abandoned
    attribute :status, code

    # Do NOT do
    attribute :prohibited, boolean

    # When activity is to occur
    attribute :timing[x], Schedule

    # Where it should happen
    attribute :location, Resource(Location)

    # Who's responsible?
    attribute :performer, Resource(Practitioner|Organization|RelatedPerson|Patient)

    # What's administered/supplied
    attribute :product, Resource(Medication|Substance)

    # How much consumed/day?
    attribute :dailyAmount, Quantity

    # How much is administered/supplied/consumed
    attribute :quantity, Quantity

    # Extra info on activity occurrence
    attribute :details, String

    # Appointments, orders, etc.
    attribute :actionTaken, Resource(Any)

    # Comments about the activity
    attribute :notes, String

  end
  # Comments about the plan
  attribute :notes, String

end
