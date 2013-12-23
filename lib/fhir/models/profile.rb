# A Resource Profile - a statement of use of one or more
# FHIR Resources.  It may include constraints on Resources and
# Data Types, Terminology Binding Statements and Extension
# Definitions.
class Fhir::Profile < Fhir::Resource
  invariants do
    validates_presence_of :name
    validates_presence_of :status
  end

  # Extensions that cannot be ignored
  attribute :modifier_extension, Array[Fhir::Extension]

  # Text summary of the resource, for human interpretation
  attribute :text, Fhir::Narrative

  # Logical id to reference this profile
  attribute :identifier, String

  # Logical id for this version of the profile
  attribute :version, String

  # Informal name for this profile
  attribute :name, String

  # Name of the publisher (Organization or individual)
  attribute :publisher, String

  # Contact information of the publisher
  attribute :telecom, Array[Fhir::Contact]

  # Natural language description of the profile
  attribute :description, String

  # Assist with indexing and finding
  attribute :code, Array[Fhir::Coding]

  # draft | active | retired
  attribute :status, Fhir::Code

  # If for testing purposes, not real usage
  attribute :experimental, Boolean

  # Date for this version of the profile
  attribute :date, DateTime

  # FHIR Version this profile targets
  attribute :fhir_version, String

  # An external specification that the content is mapped to.
  class Mapping < Fhir::ValueObject
    invariants do
      validates_presence_of :identity
    end

    # Extensions that cannot be ignored
    attribute :modifier_extension, Array[Fhir::Extension]

    # Internal id when this mapping is used
    attribute :identity, String

    # Identifies what this mapping refers to
    attribute :uri, Fhir::URI

    # Names what this mapping refers to
    attribute :name, String

    # Versions, Issues, Scope limitations etc
    attribute :comments, String
  end

  attribute :mapping, Array[Mapping]

  # A constraint statement about what contents a resource or
  # data type may have.
  class Structure < Fhir::ValueObject
    invariants do
      validates_presence_of :type
    end

    # Extensions that cannot be ignored
    attribute :modifier_extension, Array[Fhir::Extension]

    # The Resource or Data Type being described
    attribute :type, Fhir::Code

    # Name for this particular structure (reference target)
    attribute :name, String

    # This definition is published (i.e. for validation)
    attribute :publish, Boolean

    # Human summary: why describe this resource?
    attribute :purpose, String

    # Captures constraints on each element within the resource.
    class Element < Fhir::ValueObject
      invariants do
        validates_presence_of :path
      end

      # Extensions that cannot be ignored
      attribute :modifier_extension, Array[Fhir::Extension]

      # The path of the element (see the formal definitions)
      attribute :path, String

      # How this element is represented in instances
      attribute :representation, Array[Fhir::Code]

      # Name for this particular element definition (reference
      # target)
      attribute :name, String

      # Indicates that the element is sliced into a set of
      # alternative definitions (there are multiple definitions on a
      # single element in the base resource). The set of slices is
      # any elements that come after this in the element sequence
      # that have the same path, until a shorter path occurs (the
      # shorter path terminates the set).
      class Slicing < Fhir::ValueObject
        invariants do
          validates_presence_of :discriminator
          validates_inclusion_of :ordered, in: [true, false], message: 'must be either true or false'
          validates_presence_of :rules
        end

        # Extensions that cannot be ignored
        attribute :modifier_extension, Array[Fhir::Extension]

        # Element that used to distinguish the slices
        attribute :discriminator, String

        # If elements must be in same order as slices
        attribute :ordered, Boolean

        # closed | open | openAtEnd
        attribute :rules, Fhir::Code
      end

      attribute :slicing, Slicing

      # Definition of the content of the element to provide a more
      # specific definition than that contained for the element in
      # the base resource.
      class Definition < Fhir::ValueObject
        invariants do
          validates_presence_of :short
          validates_presence_of :formal
          validates_presence_of :min
          validates_presence_of :max
          validates_inclusion_of :is_modifier, in: [true, false], message: 'must be either true or false'
        end

        # Extensions that cannot be ignored
        attribute :modifier_extension, Array[Fhir::Extension]

        # Concise definition for xml presentation
        attribute :short, String

        # Full formal definition in human language
        attribute :formal, String

        # Comments about the use of this element
        attribute :comments, String

        # Why is this needed?
        attribute :requirements, String

        # Other names
        attribute :synonym, Array[String]

        # Minimum Cardinality
        attribute :min, Integer

        # Maximum Cardinality (a number or *)
        attribute :max, String

        # The data type or resource that the value of this element
        # is permitted to be.
        class Type < Fhir::ValueObject
          invariants do
            validates_presence_of :code
          end

          # Extensions that cannot be ignored
          attribute :modifier_extension, Array[Fhir::Extension]

          # Name of Data type or Resource
          attribute :code, Fhir::Code

          # Profile.structure to apply
          attribute :profile, Fhir::URI

          # contained | referenced | bundled - how aggregated
          attribute :aggregation, Array[Fhir::Code]
        end

        attribute :type, Array[Type]

        # To another element constraint (by element.name)
        attribute :name_reference, String

        # Fixed value: [as defined for type]
        attribute :value, Object

        # Example value: [as defined for type]
        attribute :example, Object

        # Length for strings
        attribute :max_length, Integer

        # Reference to invariant about presence
        attribute :condition, Array[String]

        # Formal constraints such as co-occurrence and other
        # constraints that can be computationally evaluated within the
        # context of the instance.
        class Constraint < Fhir::ValueObject
          invariants do
            validates_presence_of :key
            validates_presence_of :severity
            validates_presence_of :human
            validates_presence_of :xpath
          end

          # Extensions that cannot be ignored
          attribute :modifier_extension, Array[Fhir::Extension]

          # Target of 'condition' reference above
          attribute :key, String

          # Short human label
          attribute :name, String

          # error | warning
          attribute :severity, Fhir::Code

          # Human description of constraint
          attribute :human, String

          # XPath expression of constraint
          attribute :xpath, String
        end

        attribute :constraint, Array[Constraint]

        # If the element must supported
        attribute :must_support, Boolean

        # If this modifies the meaning of other elements
        attribute :is_modifier, Boolean

        # Binds to a value set if this element is coded (code,
        # Coding, CodeableConcept).
        class Binding < Fhir::ValueObject
          invariants do
            validates_presence_of :name
            validates_inclusion_of :is_extensible, in: [true, false], message: 'must be either true or false'
          end

          # Extensions that cannot be ignored
          attribute :modifier_extension, Array[Fhir::Extension]

          # Descriptive Name
          attribute :name, String

          # Can additional codes be used?
          attribute :is_extensible, Boolean

          # required | preferred | example
          attribute :conformance, Fhir::Code

          # Human explanation of the value set
          attribute :description, String

          # Source of value set
          resource_reference :reference, [Fhir::ValueSet]
        end

        attribute :binding, Binding

        # Identifies a concept from an external specification that
        # roughly corresponds to this element.
        class Mapping < Fhir::ValueObject
          invariants do
            validates_presence_of :identity
            validates_presence_of :map
          end

          # Extensions that cannot be ignored
          attribute :modifier_extension, Array[Fhir::Extension]

          # Reference to mapping declaration
          attribute :identity, String

          # Details of the mapping
          attribute :map, String
        end

        attribute :mapping, Array[Mapping]
      end

      attribute :definition, Definition
    end

    attribute :element, Array[Element]
  end

  attribute :structure, Array[Structure]

  # An extension defined as part of the profile.
  class ExtensionDefn < Fhir::ValueObject
    invariants do
      validates_presence_of :code
      validates_presence_of :context_type
      validates_presence_of :context
      validates_presence_of :definition
    end

    # Extensions that cannot be ignored
    attribute :modifier_extension, Array[Fhir::Extension]

    # Identifies the extension in this profile
    attribute :code, Fhir::Code

    # Use this name when displaying the value
    attribute :display, String

    # resource | datatype | mapping | extension
    attribute :context_type, Fhir::Code

    # Where the extension can be used in instances
    attribute :context, Array[String]

    # Definition of the extension and its content
    attribute :definition, Fhir::Profile::Structure::Element::Definition
  end

  attribute :extension_defn, Array[ExtensionDefn]
end


Fhir.load_extension('profile')
