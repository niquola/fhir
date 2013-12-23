# Provenance information that describes the activity that
# lead to the creation of a set of resources. This information
# can be used to help determine their reliability or trace
# where the information in them came from. The focus of the
# provenance resource is record keeping, audit and
# traceability, and not explicit statements of clinical
# significance.
class Fhir::Provenance < Fhir::Resource
  invariants do
    validates_presence_of :target_ref
    validates_presence_of :recorded
  end

  # Extensions that cannot be ignored
  attribute :modifier_extension, Array[Fhir::Extension]

  # Text summary of the resource, for human interpretation
  attribute :text, Fhir::Narrative

  # Target resource(s) (usually version specific)
  resource_references :target, [Fhir::Resource]

  # When the activity occurred
  attribute :period, Fhir::Period

  # When the activity was recorded / updated
  attribute :recorded, DateTime

  # Reason the activity is occurring
  attribute :reason, Fhir::CodeableConcept

  # Where the activity occurred, if relevant
  resource_reference :location, [Fhir::Location]

  # Policy or plan the activity was defined by
  attribute :policy, Array[Fhir::URI]

  # An agent takes a role in an activity such that the agent
  # can be assigned some degree of responsibility for the
  # activity taking place. An agent can be a person, a piece of
  # software, an inanimate object, an organization, or other
  # entities that may be ascribed responsibility.
  class Agent < Fhir::ValueObject
    invariants do
      validates_presence_of :role
      validates_presence_of :type
      validates_presence_of :reference
    end

    # Extensions that cannot be ignored
    attribute :modifier_extension, Array[Fhir::Extension]

    # e.g. author | overseer | enterer | attester | source | cc:
    # +
    attribute :role, Fhir::Coding

    # e.g. Resource | Person | Application | Record | Document +
    attribute :type, Fhir::Coding

    # Identity of agent (urn or url)
    attribute :reference, Fhir::URI

    # Human description of participant
    attribute :display, String
  end

  attribute :agent, Array[Agent]

  # An entity used in this activity.
  class Entity < Fhir::ValueObject
    invariants do
      validates_presence_of :role
      validates_presence_of :type
      validates_presence_of :reference
    end

    # Extensions that cannot be ignored
    attribute :modifier_extension, Array[Fhir::Extension]

    # derivation | revision | quotation | source
    attribute :role, Fhir::Code

    # Resource Type, or something else
    attribute :type, Fhir::Coding

    # Identity of participant (urn or url)
    attribute :reference, Fhir::URI

    # Human description of participant
    attribute :display, String

    # Entity is attributed to this agent
    attribute :agent, Fhir::Provenance::Agent
  end

  attribute :entity, Array[Entity]

  # Base64 signature (DigSig) - integrity check
  attribute :integrity_signature, String
end


Fhir.load_extension('provenance')
