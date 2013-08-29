# A set of codes drawn from one or more code systems
class ValueSet
  include Virtus
  # Additional Content defined by implementations
  attribute :extension, Extension

  # Text summary of the resource, for human interpretation
  attribute :text, Narrative

  # Contained, inline Resources
  attribute :contained, Resource

  # Logical id to reference this value set
  attribute :identifier, String

  # Logical id for this version of the value set
  attribute :version, String

  # Informal name for this value set
  attribute :name, String

  # Name of the publisher (Organization or individual)
  attribute :publisher, String

  # Contact information of the publisher
  attribute :telecom, Contact

  # Human language description of the value set
  attribute :description, String

  # About the value set or its content
  attribute :copyright, String

  # draft | experimental | review | production | withdrawn | superseded
  attribute :status, code

  # If for testing purposes, not real usage
  attribute :experimental, boolean

  # Date for given status
  attribute :date, DateTime

  # When value set defines its own codes
  attribute :define, Define

  class Define
    include Virtus::ValueObject
    # URI to identify the code system
    attribute :system, uri

    # If code comparison is case sensitive
    attribute :caseSensitive, boolean

    # Concepts in the code system
    attribute :concept, Concept

    class Concept
      include Virtus::ValueObject
      # Code that identifies concept
      attribute :code, code

      # If this code is not for use as a real concept
      attribute :abstract, boolean

      # Text to Display to the user
      attribute :display, String

      # Formal Definition
      attribute :definition, String

      # Child Concepts (is-a / contains)
      attribute :concept, @ValueSet.define.concept

    end
  end
  # When value set includes codes from elsewhere
  attribute :compose, Compose

  class Compose
    include Virtus::ValueObject
    # Import the contents of another value set
    attribute :import, uri

    # Include one or more codes from a code system
    attribute :include, Include

    class Include
      include Virtus::ValueObject
      # The system the codes come from
      attribute :system, uri

      # Specific version of the code system referred to
      attribute :version, String

      # Code or concept
      attribute :code, code

      # Select codes/concepts by their properties (including relationships)
      attribute :filter, Filter

      class Filter
        include Virtus::ValueObject
        # A property defined by the code system
        attribute :property, code

        # = | is-a | is_not_a | regex
        attribute :op, code

        # Code from the system, or regex criteria
        attribute :value, code

      end
    end
    # Explicitly exclude codes
    attribute :exclude, @ValueSet.compose.include

  end
  # When value set is an expansion
  attribute :expansion, Expansion

  class Expansion
    include Virtus::ValueObject
    # Time valueset expansion happened
    attribute :timestamp, instant

    # Codes in the value set
    attribute :contains, Contains

    class Contains
      include Virtus::ValueObject
      # System value for the code
      attribute :system, uri

      # Code - if blank, this is not a choosable code
      attribute :code, code

      # User display for the concept
      attribute :display, String

      # Codes contained in this concept
      attribute :contains, @ValueSet.expansion.contains

    end
  end
end
