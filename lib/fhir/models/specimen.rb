# Sample for analysis
class Specimen
  include Virtus
  # Additional Content defined by implementations
  attribute :extension, Extension

  # Text summary of the resource, for human interpretation
  attribute :text, Narrative

  # Contained, inline Resources
  attribute :contained, Resource

  # External Identifier
  attribute :identifier, Identifier

  # Type of specimen
  attribute :type, CodeableConcept

  # Parent of specimen
  attribute :source, Source

  class Source
    include Virtus::ValueObject
    # parent | child
    attribute :relationship, code

    # The subject of the relationship
    attribute :target, Resource(Specimen)

  end
  # The subject of the report
  attribute :subject, Resource(Patient|Group|Device|Substance)

  # Accession Identifier
  attribute :accessionIdentifier, Identifier

  # Received Time
  attribute :receivedTime, DateTime

  # Collection details
  attribute :collection, Collection

  class Collection
    include Virtus::ValueObject
    # Who collected the specimen
    attribute :collector, Resource(Practitioner)

    # Collector comments
    attribute :comment, String

    # Collection time
    attribute :collectedTime, DateTime

    # The quantity of specimen collected
    attribute :quantity, Quantity

    # Specimen Collection Method
    attribute :method, CodeableConcept

    # Site of the source of the specimen
    attribute :sourceSite, CodeableConcept

  end
  # Specimen Treatments
  attribute :treatment, Treatment

  class Treatment
    include Virtus::ValueObject
    # Textual description of procedure
    attribute :description, String

    # Specimen Treatment Procedure
    attribute :procedure, CodeableConcept

    # Specimen additive
    attribute :additive, Resource(Substance)

  end
  # Specimen Container
  attribute :container, Container

  class Container
    include Virtus::ValueObject
    # Id for container
    attribute :identifier, Identifier

    # Textual description of container
    attribute :description, String

    # Specimen Container Type
    attribute :type, CodeableConcept

    # Container Capacity
    attribute :capacity, Quantity

    # Specimen Container Quantity
    attribute :specimenQuantity, Quantity

    # Container Additive
    attribute :additive, Resource(Substance)

  end
end
