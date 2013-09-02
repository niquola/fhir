# Provenance information that describes the activity that
# lead to the creation of a set of resources. This information
# can be used to help determine their reliability or trace
# where the information in them came from. The focus of the
# provenance resource is record keeping, audit and
# traceability, and not explicit statements of clinical
# significance.
class Fhir::Provenance < Fhir::Resource
  # Additional Content defined by implementations
  attribute :extensions, Array[Fhir::Extension] # Extension

  # Text summary of the resource, for human interpretation
  attribute :text, Fhir::Narrative # Narrative

  # Contained, inline Resources
  attribute :containeds, Array[Fhir::Resource] # Resource

  # Target resource(s) (usually version specific)
  # Should be present
  attribute :targets, Array[Fhir::ResourceReference] # Resource(Any)

  # When the activity occurred
  attribute :period, Fhir::Period # Period

  # When the activity was recorded / updated
  # Should be present
  attribute :recorded, DateTime # instant

  # Reason the activity is occurring
  attribute :reason, Fhir::CodeableConcept # CodeableConcept

  # Where the activity occurred, if relevant
  attribute :location, Fhir::ResourceReference[Fhir::Location] # Resource(Location)

  # Policy or plan the activity was defined by
  attribute :policies, Array[Fhir::URI] # uri

  # An agent takes a role in an activity such that the agent
  # can be assigned some degree of responsibility for the
  # activity taking place. An agent can be a person, a piece of
  # software, an inanimate object, an organization, or other
  # entities that may be ascribed responsibility.
  class Agent < Fhir::ValueObject
    # author | overseer | enterer | attester | source | cc: +
    # Should be present
    attribute :role, Fhir::Coding # Coding

    # Resource | Person | Application | Record | Document +
    # Should be present
    attribute :type, Fhir::Coding # Coding

    # Identity of agent (urn or url)
    # Should be present
    attribute :reference, Fhir::URI # uri

    # Human description of participant
    attribute :display, String # string
  end

  attribute :agents, Array[Agent] # 

  # An entity used in this activity.
  class Entity < Fhir::ValueObject
    # derivation | revision | quotation | source
    # Should be present
    attribute :role, Fhir::Code # code

    # Resource Type, or something else
    # Should be present
    attribute :type, Fhir::Coding # Coding

    # Identity of participant (urn or url)
    # Should be present
    attribute :reference, Fhir::URI # uri

    # Human description of participant
    attribute :display, String # string

    # Entity is attributed to this agent
    attribute :agent, Fhir::Provenance::Agent # @Provenance.agent
  end

  attribute :entities, Array[Entity] # 

  # Base64 Cryptographic signature of resource (DigSig)
  attribute :signature, String # string
end

