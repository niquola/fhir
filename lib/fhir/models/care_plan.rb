# Describes the intention of how one or more practitioners
# intend to deliver care for a particular patient for a period
# of time, possibly limited to care for a specific condition
# or set of conditions.
class Fhir::CarePlan < Fhir::Resource
  invariants do
    validates_presence_of :patient_ref
    validates_presence_of :status
  end

  # Text summary of the resource, for human interpretation
  attribute :text, Fhir::Narrative

  # ID for plan
  attribute :identifier, Fhir::Identifier

  # Who care plan is for
  resource_reference :patient, [Fhir::Patient]

  # planned | active | ended
  attribute :status, Fhir::Code

  # Time period plan covers
  attribute :period, Fhir::Period

  # When last updated
  attribute :modified, DateTime

  # Health issues plan addresses
  resource_references :concerns, [Fhir::Condition]

  # Identifies all people and organizations who are expected
  # to be involved in the care envisioned by this plan.
  class Participant < Fhir::ValueObject
    invariants do
      validates_presence_of :member_ref
    end

    # Type of involvement
    attribute :role, Fhir::CodeableConcept

    # Who is involved
    resource_reference :member, [Fhir::Practitioner, Fhir::RelatedPerson, Fhir::Patient, Fhir::Organization]
  end

  attribute :participants, Array[Participant]

  # Describes the intended objective(s) of carrying out the
  # Care Plan.
  class Goal < Fhir::ValueObject
    invariants do
      validates_presence_of :description
    end

    # What's the desired outcome?
    attribute :description, String

    # in progress | achieved | sustaining | abandoned
    attribute :status, Fhir::Code

    # Comments about the goal
    attribute :notes, String
  end

  attribute :goals, Array[Goal]

  # Identifies a planned action to occur as part of the plan. 
  # For example, a medication to be used, lab tests to perform,
  # self-monitoring, education, etc.
  class Activity < Fhir::ValueObject
    invariants do
      validates_presence_of :category
      validates_inclusion_of :prohibited, in: [true, false]
    end

    # encounter | procedure | observation | +
    attribute :category, Fhir::Code

    # Detail type of activity
    attribute :code, Fhir::CodeableConcept

    # not started | ongoing | suspended | completed | abandoned
    attribute :status, Fhir::Code

    # Do NOT do
    attribute :prohibited, Boolean

    # When activity is to occur
    attribute :timing, *Fhir::Type[Fhir::Schedule, Fhir::Period, String]

    # Where it should happen
    resource_reference :location, [Fhir::Location]

    # Who's responsible?
    resource_references :performers, [Fhir::Practitioner, Fhir::Organization, Fhir::RelatedPerson, Fhir::Patient]

    # What's administered/supplied
    resource_reference :product, [Fhir::Medication, Fhir::Substance]

    # How much consumed/day?
    attribute :daily_amount, Fhir::Quantity

    # How much is administered/supplied/consumed
    attribute :quantity, Fhir::Quantity

    # Extra info on activity occurrence
    attribute :details, String

    # Appointments, orders, etc.
    resource_references :action_takens, [Fhir::Resource]

    # Comments about the activity
    attribute :notes, String
  end

  attribute :activities, Array[Activity]

  # Comments about the plan
  attribute :notes, String
end

