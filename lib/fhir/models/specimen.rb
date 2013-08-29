class Specimen
  attribute :extension, Extension
  attribute :text, Narrative
  attribute :contained, Resource
  attribute :identifier, Identifier
  attribute :type, CodeableConcept
  attribute :source, Source
  class Source
    attribute :relationship, code
    attribute :target, Resource(Specimen)
  end
  attribute :subject, Resource(Patient|Group|Device|Substance)
  attribute :accessionIdentifier, Identifier
  attribute :receivedTime, DateTime
  attribute :collection, Collection
  class Collection
    attribute :collector, Resource(Practitioner)
    attribute :comment, String
    attribute :collectedTime, DateTime
    attribute :quantity, Quantity
    attribute :method, CodeableConcept
    attribute :sourceSite, CodeableConcept
  end
  attribute :treatment, Treatment
  class Treatment
    attribute :description, String
    attribute :procedure, CodeableConcept
    attribute :additive, Resource(Substance)
  end
  attribute :container, Container
  class Container
    attribute :identifier, Identifier
    attribute :description, String
    attribute :type, CodeableConcept
    attribute :capacity, Quantity
    attribute :specimenQuantity, Quantity
    attribute :additive, Resource(Substance)
  end
end
