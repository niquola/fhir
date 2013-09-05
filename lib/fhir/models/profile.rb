# A Resource Profile - a statement of use of one or more
# FHIR Resources.  It may include constraints on Resources and
# Data Types, Terminology Binding Statements and Extension
# Definitions.
class Fhir::Profile < Fhir::Resource
  invariants do
    validates_presence_of :name
    validates_presence_of :status
  end

  # Logical id to reference this profile
  attribute :identifier, String

  # Logical id for this version of the profile
  attribute :version, String

  # Informal name for this profile
  # Should be present
  attribute :name, String

  # Name of the publisher (Organization or individual)
  attribute :publisher, String

  # Contact information of the publisher
  attribute :telecoms, Array[Fhir::Contact]

  # Natural language description of the profile
  attribute :description, String

  # Assist with indexing and finding
  attribute :codes, Array[Fhir::Coding]

  # draft | experimental | review | production | withdrawn |
  # superseded
  # Should be present
  attribute :status, Fhir::Code

  # If for testing purposes, not real usage
  attribute :experimental, Boolean

  # Date for this version of the profile
  attribute :date, DateTime

  # FHIR Version this profile targets
  attribute :fhir_version, String

  # A constraint statement about what contents a resource or
  # data type may have.
  class Structure < Fhir::ValueObject
    invariants do
      validates_presence_of :type
    end

    # The Resource or Data Type being described
    # Should be present
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

      # The path of the element (see the formal definitions)
      # Should be present
      attribute :path, String

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
          validates_presence_of :ordered
          validates_presence_of :rules
        end

        # Element that used to distinguish the slices
        # Should be present
        attribute :discriminator, String

        # If elements must be in same order as slices
        # Should be present
        attribute :ordered, Boolean

        # Whether slice list is open or closed
        # Should be present
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
          validates_presence_of :is_modifier
        end

        # Concise definition for xml presentation
        # Should be present
        attribute :short, String

        # Formal definition
        # Should be present
        attribute :formal, String

        # Comments about the use of this element
        attribute :comments, String

        # Why is this needed?
        attribute :requirements, String

        # Other names
        attribute :synonyms, Array[String]

        # Minimum Cardinality
        # Should be present
        attribute :min, Integer

        # Maximum Cardinality (a number or *)
        # Should be present
        attribute :max, String

        # The data type or resource that the value of this element
        # is permitted to be.
        class Type < Fhir::ValueObject
          invariants do
            validates_presence_of :code
          end

          # Data type or Resource
          # Should be present
          attribute :code, Fhir::Code

          # Profile.structure to apply
          attribute :profile, Fhir::URI

          # If code is a Resource, is it in the bundle?
          attribute :bundled, Boolean
        end

        attribute :types, Array[Type]

        # To another element constraint (by element.name)
        attribute :name_reference, String

        # Fixed value: [as defined for type]
        attribute :value, Object

        # Example value: [as defined for type]
        attribute :example, Object

        # Length for strings
        attribute :max_length, Integer

        # Reference to invariant about presence
        attribute :conditions, Array[String]

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

          # Target of 'condition' reference above
          # Should be present
          attribute :key, String

          # Short human label
          attribute :name, String

          # error | warning
          # Should be present
          attribute :severity, Fhir::Code

          # Human description of constraint
          # Should be present
          attribute :human, String

          # XPath expression of constraint
          # Should be present
          attribute :xpath, String

          # OCL expression of constraint
          attribute :ocl, String
        end

        attribute :constraints, Array[Constraint]

        # If the element must be usable
        attribute :must_support, Boolean

        # If this modifies the meaning of other elements
        # Should be present
        attribute :is_modifier, Boolean

        # Reference to a binding (local or absolute)
        attribute :binding, Fhir::URI

        # Identifies a concept from an external specification that
        # roughly corresponds to this element.
        class Mapping < Fhir::ValueObject
          invariants do
            validates_presence_of :target
          end

          # Which mapping this is (v2, CDA, openEHR, etc.)
          # Should be present
          attribute :target, Fhir::URI

          # Details of the mapping
          attribute :map, String
        end

        attribute :mappings, Array[Mapping]
      end

      attribute :definition, Definition
    end

    attribute :elements, Array[Element]
  end

  attribute :structures, Array[Structure]

  # An extension defined as part of the profile.
  class ExtensionDefn < Fhir::ValueObject
    invariants do
      validates_presence_of :code
      validates_presence_of :context_type
      validates_presence_of :contexts
      validates_presence_of :definition
    end

    # Identifies the extension in this profile
    # Should be present
    attribute :code, Fhir::Code

    # resource | datatype | mapping | extension
    # Should be present
    attribute :context_type, Fhir::Code

    # Where the extension can be used in instances
    # Should be present
    attribute :contexts, Array[String]

    # Definition of the extension and its content
    # Should be present
    attribute :definition, Fhir::Profile::Structure::Element::Definition
  end

  attribute :extension_defns, Array[ExtensionDefn]

  # Defines a linkage between a vocabulary binding name used
  # in the profile (or expected to be used in profile importing
  # this one) and a value set or code list.
  class Binding < Fhir::ValueObject
    invariants do
      validates_presence_of :name
    end

    # Binding name
    # Should be present
    attribute :name, String

    # Can additional codes be used?
    attribute :is_extensible, Boolean

    # required | preferred | example
    attribute :conformance, Fhir::Code

    # Human explanation of the binding
    attribute :description, String

    # Source of binding content
    resource_reference :reference, [Fhir::ValueSet]
  end

  attribute :bindings, Array[Binding]
end

