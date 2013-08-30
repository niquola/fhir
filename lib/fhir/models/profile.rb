# A Resource Profile - a statement of use of one or more
# FHIR Resources.  It may include constraints on Resources and
# Data Types, Terminology Binding Statements and Extension
# Definitions.
class Fhir::Profile < Fhir::Resource
  # Additional Content defined by implementations
  attribute :extension, Array[Extension]

  # Text summary of the resource, for human interpretation
  attribute :text, Narrative

  # Contained, inline Resources
  attribute :contained, Array[ResourceLink[Resource]]

  # Logical id to reference this profile
  attribute :identifier, string

  # Logical id for this version of the profile
  attribute :version, string

  # Informal name for this profile
  # Should be present
  attribute :name, string

  # Name of the publisher (Organization or individual)
  attribute :publisher, string

  # Contact information of the publisher
  attribute :telecom, Array[Contact]

  # Natural language description of the profile
  attribute :description, string

  # Assist with indexing and finding
  attribute :code, Array[Coding]

  # draft | experimental | review | production | withdrawn |
  # superseded
  # Should be present
  attribute :status, code

  # If for testing purposes, not real usage
  attribute :experimental, boolean

  # Date for this version of the profile
  attribute :date, dateTime

  # FHIR Version this profile targets
  attribute :fhir_version, id

  # A constraint statement about what contents a resource or
  # data type may have.
  class Structure < Fhir::ValueObject
    # The Resource or Data Type being described
    # Should be present
    attribute :type, code

    # Name for this particular structure (reference target)
    attribute :name, string

    # This definition is published (i.e. for validation)
    attribute :publish, boolean

    # Human summary: why describe this resource?
    attribute :purpose, string

    # Captures constraints on each element within the resource.
    class Element < Fhir::ValueObject
      # The path of the element (see the formal definitions)
      # Should be present
      attribute :path, string

      # Name for this particular element definition (reference
      # target)
      attribute :name, string

      # Indicates that the element is sliced into a set of
      # alternative definitions (there are multiple definitions on a
      # single element in the base resource). The set of slices is
      # any elements that come after this in the element sequence
      # that have the same path, until a shorter path occurs (the
      # shorter path terminates the set).
      class Slicing < Fhir::ValueObject
        # Element that used to distinguish the slices
        # Should be present
        attribute :discriminator, id

        # If elements must be in same order as slices
        # Should be present
        attribute :ordered, boolean

        # Whether slice list is open or closed
        # Should be present
        attribute :rules, code
      end

      attribute :slicing, Slicing

      # Definition of the content of the element to provide a more
      # specific definition than that contained for the element in
      # the base resource.
      class Definition < Fhir::ValueObject
        # Concise definition for xml presentation
        # Should be present
        attribute :short, string

        # Formal definition
        # Should be present
        attribute :formal, string

        # Comments about the use of this element
        attribute :comments, string

        # Why is this needed?
        attribute :requirements, string

        # Other names
        attribute :synonym, Array[string]

        # Minimum Cardinality
        # Should be present
        attribute :min, integer

        # Maximum Cardinality (a number or *)
        # Should be present
        attribute :max, string

        # The data type or resource that the value of this element
        # is permitted to be.
        class Type < Fhir::ValueObject
          # Data type or Resource
          # Should be present
          attribute :code, code

          # Profile.structure to apply
          attribute :profile, uri

          # If code is a Resource, is it in the bundle?
          attribute :bundled, boolean
        end

        attribute :type, Array[Type]

        # To another element constraint (by element.name)
        attribute :name_reference, string

        # Fixed value: [as defined for type]
        attribute :value[x], *

        # Example value: [as defined for type]
        attribute :example[x], *

        # Length for strings
        attribute :max_length, integer

        # Reference to invariant about presence
        attribute :condition, Array[id]

        # Formal constraints such as co-occurrence and other
        # constraints that can be computationally evaluated within the
        # context of the instance.
        class Constraint < Fhir::ValueObject
          # Target of 'condition' reference above
          # Should be present
          attribute :key, id

          # Short human label
          attribute :name, string

          # error | warning
          # Should be present
          attribute :severity, code

          # Human description of constraint
          # Should be present
          attribute :human, string

          # XPath expression of constraint
          # Should be present
          attribute :xpath, string

          # OCL expression of constraint
          attribute :ocl, string
        end

        attribute :constraint, Array[Constraint]

        # If the element must be usable
        attribute :must_support, boolean

        # If this modifies the meaning of other elements
        # Should be present
        attribute :is_modifier, boolean

        # Reference to a binding (local or absolute)
        attribute :binding, uri

        # Identifies a concept from an external specification that
        # roughly corresponds to this element.
        class Mapping < Fhir::ValueObject
          # Which mapping this is (v2, CDA, openEHR, etc.)
          # Should be present
          attribute :target, uri

          # Details of the mapping
          attribute :map, string
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
    # Identifies the extension in this profile
    # Should be present
    attribute :code, code

    # resource | datatype | mapping | extension
    # Should be present
    attribute :context_type, code

    # Where the extension can be used in instances
    # Should be present
    attribute :context, Array[string]

    # Definition of the extension and its content
    # Should be present
    attribute :definition, @Profile.structure.element.definition
  end

  attribute :extension_defn, Array[ExtensionDefn]

  # Defines a linkage between a vocabulary binding name used
  # in the profile (or expected to be used in profile importing
  # this one) and a value set or code list.
  class Binding < Fhir::ValueObject
    # Binding name
    # Should be present
    attribute :name, string

    # Can additional codes be used?
    attribute :is_extensible, boolean

    # required | preferred | example
    attribute :conformance, code

    # Human explanation of the binding
    attribute :description, string

    # Source of binding content
    attribute :reference[x], uri
  end

  attribute :binding, Array[Binding]
end

