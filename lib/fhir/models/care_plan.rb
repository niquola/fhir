# Describes the intention of how one or more practitioners
# intend to deliver care for a particular patient for a period
# of time, possibly limited to care for a specific condition
# or set of conditions.
class Fhir::CarePlan < Fhir::Resource
  invariants do
    validates_presence_of :status
  end

  # Extensions that cannot be ignored
  attribute :modifier_extension, Array[Fhir::Extension]

  # Text summary of the resource, for human interpretation
  attribute :text, Fhir::Narrative

  # External Ids for this plan
  attribute :identifier, Array[Fhir::Identifier]

  # Who care plan is for
  resource_reference :patient, [Fhir::Patient]

  # planned | active | completed
  attribute :status, Fhir::Code

  # Time period plan covers
  attribute :period, Fhir::Period

  # When last updated
  attribute :modified, DateTime

  # Health issues this plan addresses
  resource_references :concern, [Fhir::Condition]

  # Identifies all people and organizations who are expected
  # to be involved in the care envisioned by this plan.
  class Participant < Fhir::ValueObject
    invariants do
      validates_presence_of :member_ref
    end

    # Extensions that cannot be ignored
    attribute :modifier_extension, Array[Fhir::Extension]

    # Type of involvement
    attribute :role, Fhir::CodeableConcept

    # Who is involved
    resource_reference :member, [Fhir::Practitioner, Fhir::RelatedPerson, Fhir::Patient, Fhir::Organization]
  end

  attribute :participant, Array[Participant]

  # Describes the intended objective(s) of carrying out the
  # Care Plan.
  class Goal < Fhir::ValueObject
    invariants do
      validates_presence_of :description
    end

    # Extensions that cannot be ignored
    attribute :modifier_extension, Array[Fhir::Extension]

    # What's the desired outcome?
    attribute :description, String

    # in progress | achieved | sustaining | cancelled
    attribute :status, Fhir::Code

    # Comments about the goal
    attribute :notes, String

    # Health issues this goal addresses
    resource_references :concern, [Fhir::Condition]
  end

  attribute :goal, Array[Goal]

  # Identifies a planned action to occur as part of the plan. 
  # For example, a medication to be used, lab tests to perform,
  # self-monitoring, education, etc.
  class Activity < Fhir::ValueObject
    invariants do
      validates_inclusion_of :prohibited, in: [true, false], message: 'must be either true or false'
    end

    # Extensions that cannot be ignored
    attribute :modifier_extension, Array[Fhir::Extension]

    # Goals this activity relates to
    attribute :goal, Array[Integer]

    # not started | scheduled | in progress | on hold |
    # completed | cancelled
    attribute :status, Fhir::Code

    # Do NOT do
    attribute :prohibited, Boolean

    # Appointments, orders, etc.
    resource_references :action_resulting, [Fhir::Resource]

    # Comments about the activity
    attribute :notes, String

    # Activity details defined in specific resource
    resource_reference :detail, [Fhir::Procedure, Fhir::MedicationPrescription, Fhir::DiagnosticOrder, Fhir::Encounter]

    # A simple summary of details suitable for a general care
    # plan system (e.g. form driven) that doesn't know about
    # specific resources such as procedure etc.
    class Simple < Fhir::ValueObject
      invariants do
        validates_presence_of :category
      end

      # Extensions that cannot be ignored
      attribute :modifier_extension, Array[Fhir::Extension]

      # diet | drug | encounter | observation | procedure | supply
      # | other
      attribute :category, Fhir::Code

      # Detail type of activity
      attribute :code, Fhir::CodeableConcept

      # When activity is to occur
      attribute :timing, *Fhir::Type[Fhir::Schedule, Fhir::Period, String]

      # Where it should happen
      resource_reference :location, [Fhir::Location]

      # Who's responsible?
      resource_references :performer, [Fhir::Practitioner, Fhir::Organization, Fhir::RelatedPerson, Fhir::Patient]

      # What's administered/supplied
      resource_reference :product, [Fhir::Medication, Fhir::Substance]

      # How much consumed/day?
      attribute :daily_amount, Fhir::Quantity

      # How much is administered/supplied/consumed
      attribute :quantity, Fhir::Quantity

      # Extra info on activity occurrence
      attribute :details, String
    end

    attribute :simple, Simple
  end

  attribute :activity, Array[Activity]

  # Comments about the plan
  attribute :notes, String
end


Fhir.load_extension('care_plan')
