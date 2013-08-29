# Who, What, When for a set of resources
class Provenance
  include Virtus
  # Additional Content defined by implementations
  attribute :extension, Extension

  # Text summary of the resource, for human interpretation
  attribute :text, Narrative

  # Contained, inline Resources
  attribute :contained, Resource

  # Target resource(s) (usually version specific)
  attribute :target, Resource(Any)

  # When the activity occurred
  attribute :period, Period

  # When the activity was recorded / updated
  attribute :recorded, instant

  # Reason the activity is occurring
  attribute :reason, CodeableConcept

  # Where the activity occurred, if relevant
  attribute :location, Resource(Location)

  # Policy or plan the activity was defined by
  attribute :policy, uri

  # Person, organization, records, etc. involved in creating resource
  attribute :agent, Agent

  class Agent
    include Virtus::ValueObject
    # author | overseer | enterer | attester | source | cc: +
    attribute :role, Coding

    # Resource | Person | Application | Record | Document +
    attribute :type, Coding

    # Identity of agent (urn or url)
    attribute :reference, uri

    # Human description of participant
    attribute :display, String

  end
  # An entity used in this activity
  attribute :entity, Entity

  class Entity
    include Virtus::ValueObject
    # derivation | revision | quotation | source
    attribute :role, code

    # Resource Type, or something else
    attribute :type, Coding

    # Identity of participant (urn or url)
    attribute :reference, uri

    # Human description of participant
    attribute :display, String

    # Entity is attributed to this agent
    attribute :agent, @Provenance.agent

  end
  # Base64 Cryptographic signature of resource (DigSig)
  attribute :signature, String

end
