# Resource Profile
class Profile
  include Virtus
  # Additional Content defined by implementations
  attribute :extension, Extension

  # Text summary of the resource, for human interpretation
  attribute :text, Narrative

  # Contained, inline Resources
  attribute :contained, Resource

  # Logical id to reference this profile
  attribute :identifier, String

  # Logical id for this version of the profile
  attribute :version, String

  # Informal name for this profile
  attribute :name, String

  # Name of the publisher (Organization or individual)
  attribute :publisher, String

  # Contact information of the publisher
  attribute :telecom, Contact

  # Natural language description of the profile
  attribute :description, String

  # Assist with indexing and finding
  attribute :code, Coding

  # draft | experimental | review | production | withdrawn | superseded
  attribute :status, code

  # If for testing purposes, not real usage
  attribute :experimental, boolean

  # Date for this version of the profile
  attribute :date, DateTime

  # FHIR Version this profile targets
  attribute :fhirVersion, id

  # A constraint on a resource or a data type
  attribute :structure, Structure

  class Structure
    include Virtus::ValueObject
    # The Resource or Data Type being described
    attribute :type, code

    # Name for this particular structure (reference target)
    attribute :name, String

    # This definition is published (i.e. for validation)
    attribute :publish, boolean

    # Human summary: why describe this resource?
    attribute :purpose, String

    # Definition of elements in the resource (if no profile)
    attribute :element, Element

    class Element
      include Virtus::ValueObject
      # The path of the element (see the formal definitions)
      attribute :path, String

      # Name for this particular element definition (reference target)
      attribute :name, String

      # This element is sliced - slices follow
      attribute :slicing, Slicing

      class Slicing
        include Virtus::ValueObject
        # Element that used to distinguish the slices
        attribute :discriminator, id

        # If elements must be in same order as slices
        attribute :ordered, boolean

        # Whether slice list is open or closed
        attribute :rules, code

      end
      # More specific definition of the element
      attribute :definition, Definition

      class Definition
        include Virtus::ValueObject
        # Concise definition for xml presentation
        attribute :short, String

        # Formal definition
        attribute :formal, String

        # Comments about the use of this element
        attribute :comments, String

        # Why is this needed?
        attribute :requirements, String

        # Other names
        attribute :synonym, String

        # Minimum Cardinality
        attribute :min, integer

        # Maximum Cardinality (a number or *)
        attribute :max, String

        # Type of the element
        attribute :type, Type

        class Type
          include Virtus::ValueObject
          # Data type or Resource
          attribute :code, code

          # Profile.structure to apply
          attribute :profile, uri

          # If code is a Resource, is it in the bundle?
          attribute :bundled, boolean

        end
        # To another element constraint (by element.name)
        attribute :nameReference, String

        # Fixed value: [as defined for type]
        attribute :value[x], *

        # Example value: [as defined for type]
        attribute :example[x], *

        # Length for strings
        attribute :maxLength, integer

        # Reference to invariant about presence
        attribute :condition, id

        # Condition that must evaluate to true
        attribute :constraint, Constraint

        class Constraint
          include Virtus::ValueObject
          # Target of 'condition' reference above
          attribute :key, id

          # Short human label
          attribute :name, String

          # error | warning
          attribute :severity, code

          # Human description of constraint
          attribute :human, String

          # XPath expression of constraint
          attribute :xpath, String

          # OCL expression of constraint
          attribute :ocl, String

        end
        # If the element must be usable
        attribute :mustSupport, boolean

        # If this modifies the meaning of other elements
        attribute :isModifier, boolean

        # Reference to a binding (local or absolute)
        attribute :binding, uri

        # Map element to another set of definitions
        attribute :mapping, Mapping

        class Mapping
          include Virtus::ValueObject
          # Which mapping this is (v2, CDA, openEHR, etc.)
          attribute :target, uri

          # Details of the mapping
          attribute :map, String

        end
      end
    end
  end
  # Definition of an extension
  attribute :extensionDefn, ExtensionDefn

  class ExtensionDefn
    include Virtus::ValueObject
    # Identifies the extension in this profile
    attribute :code, code

    # resource | datatype | mapping | extension
    attribute :contextType, code

    # Where the extension can be used in instances
    attribute :context, String

    # Definition of the extension and its content
    attribute :definition, @Profile.structure.element.definition

  end
  # Define code sets for coded elements
  attribute :binding, Binding

  class Binding
    include Virtus::ValueObject
    # Binding name
    attribute :name, String

    # Can additional codes be used?
    attribute :isExtensible, boolean

    # required | preferred | example
    attribute :conformance, code

    # Human explanation of the binding
    attribute :description, String

    # Source of binding content
    attribute :reference[x], uri

  end
end
