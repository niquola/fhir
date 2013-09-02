# Primarily used for identification and definition of
# Medication, but also covers ingredients and packaging.
class Fhir::Medication < Fhir::Resource
  # Additional Content defined by implementations
  attribute :extensions, Array[Fhir::Extension] # Extension

  # Text summary of the resource, for human interpretation
  attribute :text, Fhir::Narrative # Narrative

  # Contained, inline Resources
  attribute :containeds, Array[Fhir::Resource] # Resource

  # Common / Commercial name
  attribute :name, String # string

  # References to std. medication terminologies
  attribute :code, Fhir::CodeableConcept # CodeableConcept

  # True if a brand
  attribute :is_brand, Boolean # boolean

  # Manufacturer of the item
  attribute :manufacturer, Fhir::ResourceReference[Fhir::Organization] # Resource(Organization)

  # product | package
  attribute :kind, Fhir::Code # code

  # If is a product.
  class Product < Fhir::ValueObject
    # Powder | tablets | carton etc
    attribute :form, Fhir::CodeableConcept # CodeableConcept

    # The ingredients of the medication.
    class Ingredient < Fhir::ValueObject
      # Ingredient
      # Should be present
      attribute :item, Fhir::ResourceReference[Fhir::Substance, Fhir::Medication] # Resource(Substance|Medication)

      # Amount of ingredient
      attribute :amount, Fhir::Ratio # Ratio
    end

    attribute :ingredients, Array[Ingredient] # 
  end

  attribute :product, Product # 

  # Specifies Ingredient / Product / Package.
  class Package < Fhir::ValueObject
    # Kind of container
    attribute :container, Fhir::CodeableConcept # CodeableConcept

    # A set of components that go to make up the described item.
    class Content < Fhir::ValueObject
      # A product in the package
      # Should be present
      attribute :item, Fhir::ResourceReference[Fhir::Medication] # Resource(Medication)

      # Amount in the package
      attribute :amount, Fhir::Quantity # Quantity
    end

    attribute :contents, Array[Content] # 
  end

  attribute :package, Package # 
end

