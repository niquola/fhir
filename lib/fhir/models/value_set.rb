# A value set specifies a set of codes drawn from one or
# more code systems.
class Fhir::ValueSet < Fhir::Resource
  invariants do
    validates_presence_of :name
    validates_presence_of :description
    validates_presence_of :status
  end

  # Extensions that cannot be ignored
  attribute :modifier_extension, Array[Fhir::Extension]

  # Text summary of the resource, for human interpretation
  attribute :text, Fhir::Narrative

  # Logical id to reference this value set
  attribute :identifier, String

  # Logical id for this version of the value set
  attribute :version, String

  # Informal name for this value set
  attribute :name, String

  # Name of the publisher (Organization or individual)
  attribute :publisher, String

  # Contact information of the publisher
  attribute :telecom, Array[Fhir::Contact]

  # Human language description of the value set
  attribute :description, String

  # About the value set or its content
  attribute :copyright, String

  # draft | active | retired
  attribute :status, Fhir::Code

  # If for testing purposes, not real usage
  attribute :experimental, Boolean

  # Whether this is intended to be used with an extensible
  # binding
  attribute :extensible, Boolean

  # Date for given status
  attribute :date, DateTime

  # When value set defines its own codes.
  class Define < Fhir::ValueObject
    invariants do
      validates_presence_of :system
    end

    # Extensions that cannot be ignored
    attribute :modifier_extension, Array[Fhir::Extension]

    # URI to identify the code system
    attribute :system, Fhir::URI

    # Version of this system
    attribute :version, String

    # If code comparison is case sensitive
    attribute :case_sensitive, Boolean

    # Concepts in the code system.
    class Concept < Fhir::ValueObject
      invariants do
        validates_presence_of :code
      end

      # Extensions that cannot be ignored
      attribute :modifier_extension, Array[Fhir::Extension]

      # Code that identifies concept
      attribute :code, Fhir::Code

      # If this code is not for use as a real concept
      attribute :abstract, Boolean

      # Text to Display to the user
      attribute :display, String

      # Formal Definition
      attribute :definition, String

      # Child Concepts (is-a / contains)
      attribute :concept, Array[Fhir::ValueSet::Define::Concept]
    end

    attribute :concept, Array[Concept]
  end

  attribute :define, Define

  # When value set includes codes from elsewhere.
  class Compose < Fhir::ValueObject
    # Extensions that cannot be ignored
    attribute :modifier_extension, Array[Fhir::Extension]

    # Import the contents of another value set
    attribute :import, Array[Fhir::URI]

    # Include one or more codes from a code system.
    class Include < Fhir::ValueObject
      invariants do
        validates_presence_of :system
      end

      # Extensions that cannot be ignored
      attribute :modifier_extension, Array[Fhir::Extension]

      # The system the codes come from
      attribute :system, Fhir::URI

      # Specific version of the code system referred to
      attribute :version, String

      # Code or concept from system
      attribute :code, Array[Fhir::Code]

      # Select concepts by specify a matching criteria based on
      # the properties (including relationships) defined by the
      # system. If multiple filters are specified, they SHALL all be
      # true.
      class Filter < Fhir::ValueObject
        invariants do
          validates_presence_of :property
          validates_presence_of :op
          validates_presence_of :value
        end

        # Extensions that cannot be ignored
        attribute :modifier_extension, Array[Fhir::Extension]

        # A property defined by the code system
        attribute :property, Fhir::Code

        # = | is-a | is-not-a | regex
        attribute :op, Fhir::Code

        # Code from the system, or regex criteria
        attribute :value, Fhir::Code
      end

      attribute :filter, Array[Filter]
    end

    attribute :include, Array[Include]

    # Explicitly exclude codes
    attribute :exclude, Array[Fhir::ValueSet::Compose::Include]
  end

  attribute :compose, Compose

  # When value set is an expansion.
  class Expansion < Fhir::ValueObject
    invariants do
      validates_presence_of :timestamp
    end

    # Extensions that cannot be ignored
    attribute :modifier_extension, Array[Fhir::Extension]

    # Uniquely identifies this expansion
    attribute :identifier, Fhir::Identifier

    # Time valueset expansion happened
    attribute :timestamp, DateTime

    # Codes in the value set.
    class Contains < Fhir::ValueObject
      # Extensions that cannot be ignored
      attribute :modifier_extension, Array[Fhir::Extension]

      # System value for the code
      attribute :system, Fhir::URI

      # Code - if blank, this is not a choosable code
      attribute :code, Fhir::Code

      # User display for the concept
      attribute :display, String

      # Codes contained in this concept
      attribute :contains, Array[Fhir::ValueSet::Expansion::Contains]
    end

    attribute :contains, Array[Contains]
  end

  attribute :expansion, Expansion
end


Fhir.load_extension('value_set')
