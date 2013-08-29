class Profile
  attribute :extension, Extension
  attribute :text, Narrative
  attribute :contained, Resource
  attribute :identifier, String
  attribute :version, String
  attribute :name, String
  attribute :publisher, String
  attribute :telecom, Contact
  attribute :description, String
  attribute :code, Coding
  attribute :status, code
  attribute :experimental, boolean
  attribute :date, DateTime
  attribute :fhirVersion, id
  attribute :structure, Structure
  class Structure
    attribute :type, code
    attribute :name, String
    attribute :publish, boolean
    attribute :purpose, String
    attribute :element, Element
    class Element
      attribute :path, String
      attribute :name, String
      attribute :slicing, Slicing
      class Slicing
        attribute :discriminator, id
        attribute :ordered, boolean
        attribute :rules, code
      end
      attribute :definition, Definition
      class Definition
        attribute :short, String
        attribute :formal, String
        attribute :comments, String
        attribute :requirements, String
        attribute :synonym, String
        attribute :min, integer
        attribute :max, String
        attribute :type, Type
        class Type
          attribute :code, code
          attribute :profile, uri
          attribute :bundled, boolean
        end
        attribute :nameReference, String
        attribute :value[x], *
        attribute :example[x], *
        attribute :maxLength, integer
        attribute :condition, id
        attribute :constraint, Constraint
        class Constraint
          attribute :key, id
          attribute :name, String
          attribute :severity, code
          attribute :human, String
          attribute :xpath, String
          attribute :ocl, String
        end
        attribute :mustSupport, boolean
        attribute :isModifier, boolean
        attribute :binding, uri
        attribute :mapping, Mapping
        class Mapping
          attribute :target, uri
          attribute :map, String
        end
      end
    end
  end
  attribute :extensionDefn, ExtensionDefn
  class ExtensionDefn
    attribute :code, code
    attribute :contextType, code
    attribute :context, String
    attribute :definition, @Profile.structure.element.definition
  end
  attribute :binding, Binding
  class Binding
    attribute :name, String
    attribute :isExtensible, boolean
    attribute :conformance, code
    attribute :description, String
    attribute :reference[x], uri
  end
end
