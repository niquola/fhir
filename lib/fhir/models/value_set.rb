# A value set specifies a set of codes drawn from one or
# more code systems.
class Fhir::ValueSet < Fhir::Resource
  # Additional Content defined by implementations
  attribute :extension, Array[Fhir::Extension] # Extension

  # Text summary of the resource, for human interpretation
  attribute :text, Fhir::Narrative # Narrative

  # Contained, inline Resources
  attribute :contained, Array[Fhir::Resource] # Resource

  # Logical id to reference this value set
  attribute :identifier, String # string

  # Logical id for this version of the value set
  attribute :version, String # string

  # Informal name for this value set
  # Should be present
  attribute :name, String # string

  # Name of the publisher (Organization or individual)
  attribute :publisher, String # string

  # Contact information of the publisher
  attribute :telecom, Array[Fhir::Contact] # Contact

  # Human language description of the value set
  # Should be present
  attribute :description, String # string

  # About the value set or its content
  attribute :copyright, String # string

  # draft | experimental | review | production | withdrawn |
  # superseded
  # Should be present
  attribute :status, Fhir::Code # code

  # If for testing purposes, not real usage
  attribute :experimental, Boolean # boolean

  # Date for given status
  attribute :date, DateTime # dateTime

  # When value set defines its own codes.
  class Define < Fhir::ValueObject
    # URI to identify the code system
    # Should be present
    attribute :system, Fhir::URI # uri

    # If code comparison is case sensitive
    attribute :case_sensitive, Boolean # boolean

    # Concepts in the code system.
    class Concept < Fhir::ValueObject
      # Code that identifies concept
      # Should be present
      attribute :code, Fhir::Code # code

      # If this code is not for use as a real concept
      attribute :abstract, Boolean # boolean

      # Text to Display to the user
      attribute :display, String # string

      # Formal Definition
      attribute :definition, String # string

      # Child Concepts (is-a / contains)
      attribute :concept, Array[Fhir::ValueSet::Define::Concept] # @ValueSet.define.concept
    end

    attribute :concept, Array[Concept] # 
  end

  attribute :define, Define # 

  # When value set includes codes from elsewhere.
  class Compose < Fhir::ValueObject
    # Import the contents of another value set
    attribute :import, Array[Fhir::URI] # uri

    # Include one or more codes from a code system.
    class Include < Fhir::ValueObject
      # The system the codes come from
      # Should be present
      attribute :system, Fhir::URI # uri

      # Specific version of the code system referred to
      attribute :version, String # string

      # Code or concept
      attribute :code, Array[Fhir::Code] # code

      # Select concepts by specify a matching criteria based on
      # the properties (including relationships) defined by the
      # system. If multiple filters are specified, they must all be
      # true.
      class Filter < Fhir::ValueObject
        # A property defined by the code system
        # Should be present
        attribute :property, Fhir::Code # code

        # = | is-a | is_not_a | regex
        # Should be present
        attribute :op, Fhir::Code # code

        # Code from the system, or regex criteria
        # Should be present
        attribute :value, Fhir::Code # code
      end

      attribute :filter, Array[Filter] # 
    end

    attribute :include, Array[Include] # 

    # Explicitly exclude codes
    attribute :exclude, Array[Fhir::ValueSet::Compose::Include] # @ValueSet.compose.include
  end

  attribute :compose, Compose # 

  # When value set is an expansion.
  class Expansion < Fhir::ValueObject
    # Time valueset expansion happened
    # Should be present
    attribute :timestamp, DateTime # instant

    # Codes in the value set.
    class Contains < Fhir::ValueObject
      # System value for the code
      attribute :system, Fhir::URI # uri

      # Code - if blank, this is not a choosable code
      attribute :code, Fhir::Code # code

      # User display for the concept
      attribute :display, String # string

      # Codes contained in this concept
      attribute :contains, Array[Fhir::ValueSet::Expansion::Contains] # @ValueSet.expansion.contains
    end

    attribute :contains, Array[Contains] # 
  end

  attribute :expansion, Expansion # 
end

