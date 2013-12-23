# Primarily used for identification and definition of
# Medication, but also covers ingredients and packaging.
class Fhir::Medication < Fhir::Resource
  # Extensions that cannot be ignored
  attribute :modifier_extension, Array[Fhir::Extension]

  # Text summary of the resource, for human interpretation
  attribute :text, Fhir::Narrative

  # Common / Commercial name
  attribute :name, String

  # Codes that identify this medication
  attribute :code, Fhir::CodeableConcept

  # True if a brand
  attribute :is_brand, Boolean

  # Manufacturer of the item
  resource_reference :manufacturer, [Fhir::Organization]

  # product | package
  attribute :kind, Fhir::Code

  # If is a product.
  class Product < Fhir::ValueObject
    # Extensions that cannot be ignored
    attribute :modifier_extension, Array[Fhir::Extension]

    # Powder | tablets | carton etc
    attribute :form, Fhir::CodeableConcept

    # The ingredients of the medication.
    class Ingredient < Fhir::ValueObject
      invariants do
        validates_presence_of :item_ref
      end

      # Extensions that cannot be ignored
      attribute :modifier_extension, Array[Fhir::Extension]

      # Ingredient
      resource_reference :item, [Fhir::Substance, Fhir::Medication]

      # Amount of ingredient
      attribute :amount, Fhir::Ratio
    end

    attribute :ingredient, Array[Ingredient]
  end

  attribute :product, Product

  # Specifies Ingredient / Product / Package.
  class Package < Fhir::ValueObject
    # Extensions that cannot be ignored
    attribute :modifier_extension, Array[Fhir::Extension]

    # Kind of container
    attribute :container, Fhir::CodeableConcept

    # A set of components that go to make up the described item.
    class Content < Fhir::ValueObject
      invariants do
        validates_presence_of :item_ref
      end

      # Extensions that cannot be ignored
      attribute :modifier_extension, Array[Fhir::Extension]

      # A product in the package
      resource_reference :item, [Fhir::Medication]

      # Amount in the package
      attribute :amount, Fhir::Quantity
    end

    attribute :content, Array[Content]
  end

  attribute :package, Package
end


Fhir.load_extension('medication')
