# Primarily used for identification and definition of
# Medication, but also covers ingredients and packaging.
class Fhir::Medication < Fhir::Resource
  # Text summary of the resource, for human interpretation
  attribute :text, Fhir::Narrative

  # Common / Commercial name
  attribute :name, String

  # References to std. medication terminologies
  attribute :code, Fhir::CodeableConcept

  # True if a brand
  attribute :is_brand, Boolean

  # Manufacturer of the item
  resource_reference :manufacturer, [Fhir::Organization]

  # product | package
  attribute :kind, Fhir::Code

  # If is a product.
  class Product < Fhir::ValueObject
    # Powder | tablets | carton etc
    attribute :form, Fhir::CodeableConcept

    # The ingredients of the medication.
    class Ingredient < Fhir::ValueObject
      invariants do
        validates_presence_of :item_ref
      end

      # Ingredient
      resource_reference :item, [Fhir::Substance, Fhir::Medication]

      # Amount of ingredient
      attribute :amount, Fhir::Ratio
    end

    attribute :ingredients, Array[Ingredient]
  end

  attribute :product, Product

  # Specifies Ingredient / Product / Package.
  class Package < Fhir::ValueObject
    # Kind of container
    attribute :container, Fhir::CodeableConcept

    # A set of components that go to make up the described item.
    class Content < Fhir::ValueObject
      invariants do
        validates_presence_of :item_ref
      end

      # A product in the package
      resource_reference :item, [Fhir::Medication]

      # Amount in the package
      attribute :amount, Fhir::Quantity
    end

    attribute :contents, Array[Content]
  end

  attribute :package, Package
end

