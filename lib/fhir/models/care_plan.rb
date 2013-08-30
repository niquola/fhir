# Describes the intention of how one or more practitioners
# intend to deliver care for a particular patient for a period
# of time, possibly limited to care for a specific condition
# or set of conditions.
class Fhir::CarePlan < Fhir::Resource
  # Additional Content defined by implementations
  attribute :extension, Array[Extension]

  # Text summary of the resource, for human interpretation
  attribute :text, Narrative

  # Contained, inline Resources
  attribute :contained, Array[ResourceLink[Resource]]

  # ID for plan
  attribute :identifier, Identifier

  # Who care plan is for
  # Should be present
  attribute :patient, ResourceLink[Patient]

  # planned | active | ended
  # Should be present
  attribute :status, code

  # Time period plan covers
  attribute :period, Period

  # When last updated
  attribute :modified, dateTime

  # Health issues plan addresses
  attribute :concern, Array[ResourceLink[Condition]]

  # Identifies all people and organizations who are expected
  # to be involved in the care envisioned by this plan.
  class Participant < Fhir::ValueObject
    # Type of involvement
    attribute :role, CodeableConcept

    # Who is involved
    # Should be present
    attribute :member, ResourceLink[Practitioner, RelatedPerson, Patient, Organization]
  end

  attribute :participant, Array[Participant]

  # Describes the intended objective(s) of carrying out the
  # Care Plan.
  class Goal < Fhir::ValueObject
    # What's the desired outcome?
    # Should be present
    attribute :description, string

    # in progress | achieved | sustaining | abandoned
    attribute :status, code

    # Comments about the goal
    attribute :notes, string
  end

  attribute :goal, Array[Goal]

  # Identifies a planned action to occur as part of the plan. 
  # For example, a medication to be used, lab tests to perform,
  # self-monitoring, education, etc.
  class Activity < Fhir::ValueObject
    # encounter | procedure | observation | +
    # Should be present
    attribute :category, code

    # Detail type of activity
    attribute :code, CodeableConcept

    # not started | ongoing | suspended | completed | abandoned
    attribute :status, code

    # Do NOT do
    # Should be present
    attribute :prohibited, boolean

    # When activity is to occur
    attribute :timing[x], Schedule

    # Where it should happen
    attribute :location, ResourceLink[Location]

    # Who's responsible?
    attribute :performer, Array[ResourceLink[Practitioner, Organization, RelatedPerson, Patient]]

    # What's administered/supplied
    attribute :product, ResourceLink[Medication, Substance]

    # How much consumed/day?
    attribute :daily_amount, Quantity

    # How much is administered/supplied/consumed
    attribute :quantity, Quantity

    # Extra info on activity occurrence
    attribute :details, string

    # Appointments, orders, etc.
    attribute :action_taken, Array[ResourceLink[Any]]

    # Comments about the activity
    attribute :notes, string
  end

  attribute :activity, Array[Activity]

  # Comments about the plan
  attribute :notes, string
end

