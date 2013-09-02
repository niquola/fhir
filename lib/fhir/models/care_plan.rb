# Describes the intention of how one or more practitioners
# intend to deliver care for a particular patient for a period
# of time, possibly limited to care for a specific condition
# or set of conditions.
class Fhir::CarePlan < Fhir::Resource
  # Additional Content defined by implementations
  attribute :extensions, Array[Fhir::Extension] # Extension

  # Text summary of the resource, for human interpretation
  attribute :text, Fhir::Narrative # Narrative

  # Contained, inline Resources
  attribute :containeds, Array[Fhir::Resource] # Resource

  # ID for plan
  attribute :identifier, Fhir::Identifier # Identifier

  # Who care plan is for
  # Should be present
  attribute :patient, Fhir::ResourceReference[Fhir::Patient] # Resource(Patient)

  # planned | active | ended
  # Should be present
  attribute :status, Fhir::Code # code

  # Time period plan covers
  attribute :period, Fhir::Period # Period

  # When last updated
  attribute :modified, DateTime # dateTime

  # Health issues plan addresses
  attribute :concerns, Array[Fhir::ResourceReference[Fhir::Condition]] # Resource(Condition)

  # Identifies all people and organizations who are expected
  # to be involved in the care envisioned by this plan.
  class Participant < Fhir::ValueObject
    # Type of involvement
    attribute :role, Fhir::CodeableConcept # CodeableConcept

    # Who is involved
    # Should be present
    attribute :member, Fhir::ResourceReference[Fhir::Practitioner, Fhir::RelatedPerson, Fhir::Patient, Fhir::Organization] # Resource(Practitioner|RelatedPerson|Patient|Organization)
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
    attribute :location, Fhir::ResourceReference[Fhir::Location] # Resource(Location)

    # Who's responsible?
    attribute :performers, Array[Fhir::ResourceReference[Fhir::Practitioner, Fhir::Organization, Fhir::RelatedPerson, Fhir::Patient]] # Resource(Practitioner|Organization|RelatedPerson|Patient)

    # What's administered/supplied
    attribute :product, Fhir::ResourceReference[Fhir::Medication, Fhir::Substance] # Resource(Medication|Substance)

    # How much consumed/day?
    attribute :daily_amount, Fhir::Quantity # Quantity

    # How much is administered/supplied/consumed
    attribute :quantity, Fhir::Quantity # Quantity

    # Extra info on activity occurrence
    attribute :details, String # string

    # Appointments, orders, etc.
    attribute :action_takens, Array[Fhir::ResourceReference] # Resource(Any)

    # Comments about the activity
    attribute :notes, String # string
  end

  attribute :activities, Array[Activity] # 

  # Comments about the plan
  attribute :notes, String # string
end

