# A homogeneous material with a definite composition used in
# healthcare.
class Fhir::Substance < Fhir::Resource
  invariants do
    validates_presence_of :type
  end

  # Extensions that cannot be ignored
  attribute :modifier_extension, Array[Fhir::Extension]

  # Text summary of the resource, for human interpretation
  attribute :text, Fhir::Narrative

  # Type of the substance
  attribute :type, Fhir::CodeableConcept

  # Description of the substance
  attribute :description, String

  # Don't know ??
  attribute :status, Fhir::CodeableConcept

  # Substance may be used to desribe a kind of substance, or a
  # specific package/container of the substance: an instance.
  class Instance < Fhir::ValueObject
    # Extensions that cannot be ignored
    attribute :modifier_extension, Array[Fhir::Extension]

    # Identifier of the package/container
    attribute :identifier, Fhir::Identifier

    # When no longer valid to use
    attribute :expiry, DateTime

    # Amount of substance in the package
    attribute :quantity, Fhir::Quantity
  end

  attribute :instance, Instance

  # A substance can be composed of other substances.
  class Ingredient < Fhir::ValueObject
    invariants do
      validates_presence_of :substance_ref
    end

    # Extensions that cannot be ignored
    attribute :modifier_extension, Array[Fhir::Extension]

    # Optional amount (concentration)
    attribute :quantity, Fhir::Ratio

    # A component of the substance
    resource_reference :substance, [Fhir::Substance]
  end

  attribute :ingredient, Array[Ingredient]
end


Fhir.load_extension('substance')
