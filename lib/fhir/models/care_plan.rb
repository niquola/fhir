# Describes the intention of how one or more practitioners
# intend to deliver care for a particular patient for a period
# of time, possibly limited to care for a specific condition
# or set of conditions.
class Fhir::CarePlan < Fhir::Resource
  # ID for plan
  attribute :identifier, Fhir::Identifier # Identifier

  # Who care plan is for
  # Should be present
  resource_reference :patient, [Fhir::Patient]

  # planned | active | ended
  # Should be present
  attribute :status, Fhir::Code # code

  # Time period plan covers
  attribute :period, Fhir::Period # Period

  # When last updated
  attribute :modified, DateTime # dateTime

  # Health issues plan addresses
  resource_references :concerns, [Fhir::Condition]

  # Identifies all people and organizations who are expected
  # to be involved in the care envisioned by this plan.
  class Participant < Fhir::ValueObject
    # Type of involvement
    attribute :role, Fhir::CodeableConcept # CodeableConcept

    # Who is involved
    # Should be present
    resource_reference :member, [Fhir::Practitioner, Fhir::RelatedPerson, Fhir::Patient, Fhir::Organization]
  end

  attribute :participants, Array[Participant] # 

  # Describes the intended objective(s) of carrying out the
  # Care Plan.
  class Goal < Fhir::ValueObject
    # What's the desired outcome?
    # Should be present
    attribute :description, String # string

    # in progress | achieved | sustaining | abandoned
    attribute :status, Fhir::Code # code

    # Comments about the goal
    attribute :notes, String # string
  end

  attribute :goals, Array[Goal] # 

  # Identifies a planned action to occur as part of the plan. 
  # For example, a medication to be used, lab tests to perform,
  # self-monitoring, education, etc.
  class Activity < Fhir::ValueObject
    # encounter | procedure | observation | +
    # Should be present
    attribute :category, Fhir::Code # code

    # Detail type of activity
    attribute :code, Fhir::CodeableConcept # CodeableConcept

    # not started | ongoing | suspended | completed | abandoned
    attribute :status, Fhir::Code # code

    # Do NOT do
    # Should be present
    attribute :prohibited, Boolean # boolean

    # When activity is to occur
    attribute :timing, Fhir::Schedule # Schedule

    # Where it should happen
    resource_reference :location, [Fhir::Location]

    # Who's responsible?
    resource_references :performers, [Fhir::Practitioner, Fhir::Organization, Fhir::RelatedPerson, Fhir::Patient]

    # What's administered/supplied
    resource_reference :product, [Fhir::Medication, Fhir::Substance]

    # How much consumed/day?
    attribute :daily_amount, Fhir::Quantity # Quantity

    # How much is administered/supplied/consumed
    attribute :quantity, Fhir::Quantity # Quantity

    # Extra info on activity occurrence
    attribute :details, String # string

    # Appointments, orders, etc.
    resource_references :action_takens, [Fhir::Resource]

    # Comments about the activity
    attribute :notes, String # string
  end

  attribute :activities, Array[Activity] # 

  # Comments about the plan
  attribute :notes, String # string
end

