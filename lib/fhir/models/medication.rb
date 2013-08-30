# Primarily used for identification and definition of
# Medication, but also covers ingredients and packaging.
class Fhir::Medication < Fhir::Resource
  # Additional Content defined by implementations
  attribute :extension, Array[Extension]

  # Text summary of the resource, for human interpretation
  attribute :text, Narrative

  # Contained, inline Resources
  attribute :contained, Array[ResourceLink[Resource]]

  # Common / Commercial name
  attribute :name, string

  # References to std. medication terminologies
  attribute :code, CodeableConcept

  # True if a brand
  attribute :is_brand, boolean

  # Manufacturer of the item
  attribute :manufacturer, ResourceLink[Organization]

  # product | package
  attribute :kind, code

  # If is a product.
  class Product < Fhir::ValueObject
    # Powder | tablets | carton etc
    attribute :form, CodeableConcept

    # The ingredients of the medication.
    class Ingredient < Fhir::ValueObject
      # Ingredient
      # Should be present
      attribute :item, ResourceLink[Substance, Medication]

      # Amount of ingredient
      attribute :amount, Ratio
    end

    attribute :ingredient, Array[Ingredient]
  end

  attribute :product, Product

  # Specifies Ingredient / Product / Package.
  class Package < Fhir::ValueObject
    # Kind of container
    attribute :container, CodeableConcept

    # A set of components that go to make up the described item.
    class Content < Fhir::ValueObject
      # A product in the package
      # Should be present
      attribute :item, ResourceLink[Medication]

      # Amount in the package
      attribute :amount, Quantity
    end

    attribute :content, Array[Content]
  end

  attribute :package, Package
end

