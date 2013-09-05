# Provenance information that describes the activity that
# lead to the creation of a set of resources. This information
# can be used to help determine their reliability or trace
# where the information in them came from. The focus of the
# provenance resource is record keeping, audit and
# traceability, and not explicit statements of clinical
# significance.
class Fhir::Provenance < Fhir::Resource
  invariants do
    validates_presence_of :targets
    validates_presence_of :recorded
  end

  # Target resource(s) (usually version specific)
  # Should be present
  resource_references :targets, [Fhir::Resource]

  # When the activity occurred
  attribute :period, Fhir::Period

  # When the activity was recorded / updated
  # Should be present
  attribute :recorded, DateTime

  # Reason the activity is occurring
  attribute :reason, Fhir::CodeableConcept

  # Where the activity occurred, if relevant
  resource_reference :location, [Fhir::Location]

  # Policy or plan the activity was defined by
  attribute :policies, Array[Fhir::URI]

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

    # author | overseer | enterer | attester | source | cc: +
    # Should be present
    attribute :role, Fhir::Coding

    # Resource | Person | Application | Record | Document +
    # Should be present
    attribute :type, Fhir::Coding

    # Identity of agent (urn or url)
    # Should be present
    attribute :reference, Fhir::URI

    # Human description of participant
    attribute :display, String
  end

  attribute :agents, Array[Agent]

  # An entity used in this activity.
  class Entity < Fhir::ValueObject
    invariants do
      validates_presence_of :role
      validates_presence_of :type
      validates_presence_of :reference
    end

    # derivation | revision | quotation | source
    # Should be present
    attribute :role, Fhir::Code

    # Resource Type, or something else
    # Should be present
    attribute :type, Fhir::Coding

    # Identity of participant (urn or url)
    # Should be present
    attribute :reference, Fhir::URI

    # Human description of participant
    attribute :display, String

    # Entity is attributed to this agent
    attribute :agent, Fhir::Provenance::Agent
  end

  attribute :entities, Array[Entity]

  # Base64 Cryptographic signature of resource (DigSig)
  attribute :signature, String
end

