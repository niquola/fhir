# A Resource Profile - a statement of use of one or more
# FHIR Resources.  It may include constraints on Resources and
# Data Types, Terminology Binding Statements and Extension
# Definitions.
class Fhir::Profile < Fhir::Resource
  # Logical id to reference this profile
  attribute :identifier, String # string

  # Logical id for this version of the profile
  attribute :version, String # string

  # Informal name for this profile
  # Should be present
  attribute :name, String # string

  # Name of the publisher (Organization or individual)
  attribute :publisher, String # string

  # Contact information of the publisher
  attribute :telecoms, Array[Fhir::Contact] # Contact

  # Natural language description of the profile
  attribute :description, String # string

  # Assist with indexing and finding
  attribute :codes, Array[Fhir::Coding] # Coding

  # draft | experimental | review | production | withdrawn |
  # superseded
  # Should be present
  attribute :status, Fhir::Code # code

  # If for testing purposes, not real usage
  attribute :experimental, Boolean # boolean

  # Date for this version of the profile
  attribute :date, DateTime # dateTime

  # FHIR Version this profile targets
  attribute :fhir_version, String # id

  # A constraint statement about what contents a resource or
  # data type may have.
  class Structure < Fhir::ValueObject
    # The Resource or Data Type being described
    # Should be present
    attribute :type, Fhir::Code # code

    # Name for this particular structure (reference target)
    attribute :name, String # string

    # This definition is published (i.e. for validation)
    attribute :publish, Boolean # boolean

    # Human summary: why describe this resource?
    attribute :purpose, String # string

    # Captures constraints on each element within the resource.
    class Element < Fhir::ValueObject
      # The path of the element (see the formal definitions)
      # Should be present
      attribute :path, String # string

      # Name for this particular element definition (reference
      # target)
      attribute :name, String # string

      # Indicates that the element is sliced into a set of
      # alternative definitions (there are multiple definitions on a
      # single element in the base resource). The set of slices is
      # any elements that come after this in the element sequence
      # that have the same path, until a shorter path occurs (the
      # shorter path terminates the set).
      class Slicing < Fhir::ValueObject
        # Element that used to distinguish the slices
        # Should be present
        attribute :discriminator, String # id

        # If elements must be in same order as slices
        # Should be present
        attribute :ordered, Boolean # boolean

        # Whether slice list is open or closed
        # Should be present
        attribute :rules, Fhir::Code # code
      end

      attribute :slicing, Slicing # 

      # Definition of the content of the element to provide a more
      # specific definition than that contained for the element in
      # the base resource.
      class Definition < Fhir::ValueObject
        # Concise definition for xml presentation
        # Should be present
        attribute :short, String # string

        # Formal definition
        # Should be present
        attribute :formal, String # string

        # Comments about the use of this element
        attribute :comments, String # string

        # Why is this needed?
        attribute :requirements, String # string

        # Other names
        attribute :synonyms, Array[String] # string

        # Minimum Cardinality
        # Should be present
        attribute :min, Integer # integer

        # Maximum Cardinality (a number or *)
        # Should be present
        attribute :max, String # string

        # The data type or resource that the value of this element
        # is permitted to be.
        class Type < Fhir::ValueObject
          # Data type or Resource
          # Should be present
          attribute :code, Fhir::Code # code

          # Profile.structure to apply
          attribute :profile, Fhir::URI # uri

          # If code is a Resource, is it in the bundle?
          attribute :bundled, Boolean # boolean
        end

        attribute :types, Array[Type] # 

        # To another element constraint (by element.name)
        attribute :name_reference, String # string

        # Fixed value: [as defined for type]
        attribute :value, Object # *

        # Example value: [as defined for type]
        attribute :example, Object # *

        # Length for strings
        attribute :max_length, Integer # integer

        # Reference to invariant about presence
        attribute :conditions, Array[String] # id

        # Formal constraints such as co-occurrence and other
        # constraints that can be computationally evaluated within the
        # context of the instance.
        class Constraint < Fhir::ValueObject
          # Target of 'condition' reference above
          # Should be present
          attribute :key, String # id

          # Short human label
          attribute :name, String # string

          # error | warning
          # Should be present
          attribute :severity, Fhir::Code # code

          # Human description of constraint
          # Should be present
          attribute :human, String # string

          # XPath expression of constraint
          # Should be present
          attribute :xpath, String # string

          # OCL expression of constraint
          attribute :ocl, String # string
        end

        attribute :constraints, Array[Constraint] # 

        # If the element must be usable
        attribute :must_support, Boolean # boolean

        # If this modifies the meaning of other elements
        # Should be present
        attribute :is_modifier, Boolean # boolean

        # Reference to a binding (local or absolute)
        attribute :binding, Fhir::URI # uri

        # Identifies a concept from an external specification that
        # roughly corresponds to this element.
        class Mapping < Fhir::ValueObject
          # Which mapping this is (v2, CDA, openEHR, etc.)
          # Should be present
          attribute :target, Fhir::URI # uri

          # Details of the mapping
          attribute :map, String # string
        end

        attribute :mappings, Array[Mapping] # 
      end

      attribute :definition, Definition # 
    end

    attribute :elements, Array[Element] # 
  end

  attribute :structures, Array[Structure] # 

  # An extension defined as part of the profile.
  class ExtensionDefn < Fhir::ValueObject
    # Identifies the extension in this profile
    # Should be present
    attribute :code, Fhir::Code # code

    # resource | datatype | mapping | extension
    # Should be present
    attribute :context_type, Fhir::Code # code

    # Where the extension can be used in instances
    # Should be present
    attribute :contexts, Array[String] # string

    # Definition of the extension and its content
    # Should be present
    attribute :definition, Fhir::Profile::Structure::Element::Definition # @Profile.structure.element.definition
  end

  attribute :extension_defns, Array[ExtensionDefn] # 

  # Defines a linkage between a vocabulary binding name used
  # in the profile (or expected to be used in profile importing
  # this one) and a value set or code list.
  class Binding < Fhir::ValueObject
    # Binding name
    # Should be present
    attribute :name, String # string

    # Can additional codes be used?
    attribute :is_extensible, Boolean # boolean

    # required | preferred | example
    attribute :conformance, Fhir::Code # code

    # Human explanation of the binding
    attribute :description, String # string

    # Source of binding content
    attribute :reference, Fhir::URI # uri
  end

  attribute :bindings, Array[Binding] # 
end

