class Provenance
  attribute :extension, Extension
  attribute :text, Narrative
  attribute :contained, Resource
  attribute :target, Resource(Any)
  attribute :period, Period
  attribute :recorded, instant
  attribute :reason, CodeableConcept
  attribute :location, Resource(Location)
  attribute :policy, uri
  attribute :agent, Agent
  class Agent
    attribute :role, Coding
    attribute :type, Coding
    attribute :reference, uri
    attribute :display, String
  end
  attribute :entity, Entity
  class Entity
    attribute :role, code
    attribute :type, Coding
    attribute :reference, uri
    attribute :display, String
    attribute :agent, @Provenance.agent
  end
  attribute :signature, String
end
