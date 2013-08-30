# Sample for analysis.
class Fhir::Specimen < Fhir::Resource
  # Additional Content defined by implementations
  attribute :extension, Array[Fhir::Extension] # Extension

  # Text summary of the resource, for human interpretation
  attribute :text, Fhir::Narrative # Narrative

  # Contained, inline Resources
  attribute :contained, Array[Fhir::Resource] # Resource

  # External Identifier
  attribute :identifier, Fhir::Identifier # Identifier

  # Type of specimen
  attribute :type, Fhir::CodeableConcept # CodeableConcept

  # Parent specimen from which the focal specimen was a
  # component.
  class Source < Fhir::ValueObject
    # parent | child
    # Should be present
    attribute :relationship, Fhir::Code # code

    # The subject of the relationship
    attribute :target, Array[Fhir::ResourceReference[Fhir::Specimen]] # Resource(Specimen)
  end

  attribute :source, Array[Source] # 

  # The subject of the report
  # Should be present
  attribute :subject, Fhir::ResourceReference[Fhir::Patient, Fhir::Group, Fhir::Device, Fhir::Substance] # Resource(Patient|Group|Device|Substance)

  # Accession Identifier
  attribute :accession_identifier, Array[Fhir::Identifier] # Identifier

  # Received Time
  attribute :received_time, DateTime # dateTime

  # Details concerning the specimen collection.
  class Collection < Fhir::ValueObject
    # Who collected the specimen
    attribute :collector, Fhir::ResourceReference[Fhir::Practitioner] # Resource(Practitioner)

    # Collector comments
    attribute :comment, Array[String] # string

    # Collection time
    # Should be present
    attribute :collected_time, DateTime # dateTime

    # The quantity of specimen collected
    attribute :quantity, Fhir::Quantity # Quantity

    # Specimen Collection Method
    attribute :method, Fhir::CodeableConcept # CodeableConcept

    # Site of the source of the specimen
    attribute :source_site, Fhir::CodeableConcept # CodeableConcept
  end

  # Should be present
  attribute :collection, Collection # 

  # Details concerning treatment and processing steps for the
  # specimen.
  class Treatment < Fhir::ValueObject
    # Textual description of procedure
    attribute :description, String # string

    # Specimen Treatment Procedure
    attribute :procedure, Fhir::CodeableConcept # CodeableConcept

    # Specimen additive
    attribute :additive, Array[Fhir::ResourceReference[Fhir::Substance]] # Resource(Substance)
  end

  attribute :treatment, Array[Treatment] # 

  # The container holding the specimen. May be recursive; ie
  # blood in tube in tray in rack.
  class Container < Fhir::ValueObject
    # Id for container
    # Should be present
    attribute :identifier, Array[Fhir::Identifier] # Identifier

    # Textual description of container
    attribute :description, String # string

    # Specimen Container Type
    attribute :type, Fhir::CodeableConcept # CodeableConcept

    # Container Capacity
    attribute :capacity, Fhir::Quantity # Quantity

    # Specimen Container Quantity
    attribute :specimen_quantity, Fhir::Quantity # Quantity

    # Container Additive
    attribute :additive, Fhir::ResourceReference[Fhir::Substance] # Resource(Substance)
  end

  attribute :container, Array[Container] # 
end

