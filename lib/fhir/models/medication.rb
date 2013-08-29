class Medication
  include Virtus
  # Additional Content defined by implementations
  attribute :extension, Extension

  # Text summary of the resource, for human interpretation
  attribute :text, Narrative

  # Contained, inline Resources
  attribute :contained, Resource

  # Common / Commercial name
  attribute :name, String

  # References to std. medication terminologies
  attribute :code, CodeableConcept

  # True if a brand
  attribute :isBrand, boolean

  # Manufacturer of the item
  attribute :manufacturer, Resource(Organization)

  # product | package
  attribute :kind, code

  # If is a product
  attribute :product, Product

  class Product
    include Virtus::ValueObject
    # Powder | tablets | carton etc
    attribute :form, CodeableConcept

    # Ingredients, if specified
    attribute :ingredient, Ingredient

    class Ingredient
      include Virtus::ValueObject
      # Ingredient
      attribute :item, Resource(Substance|Medication)

      # Amount of ingredient
      attribute :amount, Ratio

    end
  end
  # If is a package
  attribute :package, Package

  class Package
    include Virtus::ValueObject
    # Kind of container
    attribute :container, CodeableConcept

    # What is  in the package
    attribute :content, Content

    class Content
      include Virtus::ValueObject
      # A product in the package
      attribute :item, Resource(Medication)

      # Amount in the package
      attribute :amount, Quantity

    end
  end
end
