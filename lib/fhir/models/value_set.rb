class ValueSet
  attribute :extension, Extension
  attribute :text, Narrative
  attribute :contained, Resource
  attribute :identifier, String
  attribute :version, String
  attribute :name, String
  attribute :publisher, String
  attribute :telecom, Contact
  attribute :description, String
  attribute :copyright, String
  attribute :status, code
  attribute :experimental, boolean
  attribute :date, DateTime
  attribute :define, Define
  class Define
    attribute :system, uri
    attribute :caseSensitive, boolean
    attribute :concept, Concept
    class Concept
      attribute :code, code
      attribute :abstract, boolean
      attribute :display, String
      attribute :definition, String
      attribute :concept, @ValueSet.define.concept
    end
  end
  attribute :compose, Compose
  class Compose
    attribute :import, uri
    attribute :include, Include
    class Include
      attribute :system, uri
      attribute :version, String
      attribute :code, code
      attribute :filter, Filter
      class Filter
        attribute :property, code
        attribute :op, code
        attribute :value, code
      end
    end
    attribute :exclude, @ValueSet.compose.include
  end
  attribute :expansion, Expansion
  class Expansion
    attribute :timestamp, instant
    attribute :contains, Contains
    class Contains
      attribute :system, uri
      attribute :code, code
      attribute :display, String
      attribute :contains, @ValueSet.expansion.contains
    end
  end
end
