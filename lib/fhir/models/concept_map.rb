# A statement of relationships from one set of concepts to
# one or more other concept systems.
class Fhir::ConceptMap < Fhir::Resource
  invariants do
    validates_presence_of :name
    validates_presence_of :description
    validates_presence_of :status
    validates_presence_of :source_ref
    validates_presence_of :target_ref
  end

  # Extensions that cannot be ignored
  attribute :modifier_extension, Array[Fhir::Extension]

  # Text summary of the resource, for human interpretation
  attribute :text, Fhir::Narrative

  # Logical id to reference this concept map
  attribute :identifier, String

  # Logical id for this version of the concept map
  attribute :version, String

  # Informal name for this concept map
  attribute :name, String

  # Name of the publisher (Organization or individual)
  attribute :publisher, String

  # Contact information of the publisher
  attribute :telecom, Array[Fhir::Contact]

  # Human language description of the concept map
  attribute :description, String

  # About the concept map or its content
  attribute :copyright, String

  # draft | active | retired
  attribute :status, Fhir::Code

  # If for testing purposes, not real usage
  attribute :experimental, Boolean

  # Date for given status
  attribute :date, DateTime

  # Identifies the source value set which is being mapped
  resource_reference :source, [Fhir::ValueSet]

  # Provides context to the mappings
  resource_reference :target, [Fhir::ValueSet]

  # Mappings for a concept.
  class Concept < Fhir::ValueObject
    # Extensions that cannot be ignored
    attribute :modifier_extension, Array[Fhir::Extension]

    # Name for this concept (if just a group)
    attribute :name, String

    # System that defines the concept being mapped
    attribute :system, Fhir::URI

    # Identifies concept being mapped
    attribute :code, Fhir::Code

    # Targets mapped to this concept.
    class Map < Fhir::ValueObject
      invariants do
        validates_presence_of :system
        validates_presence_of :equivalence
      end

      # Extensions that cannot be ignored
      attribute :modifier_extension, Array[Fhir::Extension]

      # If this code is not for use as a real concept
      attribute :system, Fhir::URI

      # Text to Display to the user
      attribute :code, String

      # equal | equivalent | wider | narrower | inexact |
      # unmatched | disjoint
      attribute :equivalence, Fhir::Code

      # Description of status/issues in mapping
      attribute :comments, String
    end

    attribute :map, Array[Map]

    # Mappings for sub concepts
    attribute :concept, Array[Fhir::ConceptMap::Concept]
  end

  attribute :concept, Array[Concept]
end


Fhir.load_extension('concept_map')
