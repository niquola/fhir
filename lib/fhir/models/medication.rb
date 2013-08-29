class Medication
  attribute :extension, Extension
  attribute :text, Narrative
  attribute :contained, Resource
  attribute :name, String
  attribute :code, CodeableConcept
  attribute :isBrand, boolean
  attribute :manufacturer, Resource(Organization)
  attribute :kind, code
  attribute :product, Product
  class Product
    attribute :form, CodeableConcept
    attribute :ingredient, Ingredient
    class Ingredient
      attribute :item, Resource(Substance|Medication)
      attribute :amount, Ratio
    end
  end
  attribute :package, Package
  class Package
    attribute :container, CodeableConcept
    attribute :content, Content
    class Content
      attribute :item, Resource(Medication)
      attribute :amount, Quantity
    end
  end
end
