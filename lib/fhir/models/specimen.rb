# Sample for analysis.
class Fhir::Specimen < Fhir::Resource
  # Additional Content defined by implementations
  attribute :extension, Array[Extension]

  # Text summary of the resource, for human interpretation
  attribute :text, Narrative

  # Contained, inline Resources
  attribute :contained, Array[ResourceLink[Resource]]

  # External Identifier
  attribute :identifier, Identifier

  # Type of specimen
  attribute :type, CodeableConcept

  # Parent specimen from which the focal specimen was a
  # component.
  class Source < Fhir::ValueObject
    # parent | child
    # Should be present
    attribute :relationship, code

    # The subject of the relationship
    attribute :target, Array[ResourceLink[Specimen]]
  end

  attribute :source, Array[Source]

  # The subject of the report
  # Should be present
  attribute :subject, ResourceLink[Patient, Group, Device, Substance]

  # Accession Identifier
  attribute :accession_identifier, Array[Identifier]

  # Received Time
  attribute :received_time, dateTime

  # Details concerning the specimen collection.
  class Collection < Fhir::ValueObject
    # Who collected the specimen
    attribute :collector, ResourceLink[Practitioner]

    # Collector comments
    attribute :comment, Array[string]

    # Collection time
    # Should be present
    attribute :collected_time, dateTime

    # The quantity of specimen collected
    attribute :quantity, Quantity

    # Specimen Collection Method
    attribute :method, CodeableConcept

    # Site of the source of the specimen
    attribute :source_site, CodeableConcept
  end

  # Should be present
  attribute :collection, Collection

  # Details concerning treatment and processing steps for the
  # specimen.
  class Treatment < Fhir::ValueObject
    # Textual description of procedure
    attribute :description, string

    # Specimen Treatment Procedure
    attribute :procedure, CodeableConcept

    # Specimen additive
    attribute :additive, Array[ResourceLink[Substance]]
  end

  attribute :treatment, Array[Treatment]

  # The container holding the specimen. May be recursive; ie
  # blood in tube in tray in rack.
  class Container < Fhir::ValueObject
    # Id for container
    # Should be present
    attribute :identifier, Array[Identifier]

    # Textual description of container
    attribute :description, string

    # Specimen Container Type
    attribute :type, CodeableConcept

    # Container Capacity
    attribute :capacity, Quantity

    # Specimen Container Quantity
    attribute :specimen_quantity, Quantity

    # Container Additive
    attribute :additive, ResourceLink[Substance]
  end

  attribute :container, Array[Container]
end

