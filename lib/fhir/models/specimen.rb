# Sample for analysis.
class Fhir::Specimen < Fhir::Resource
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
    resource_references :targets, [Fhir::Specimen]
  end

  attribute :sources, Array[Source] # 

  # The subject of the report
  # Should be present
  resource_reference :subject, [Fhir::Patient, Fhir::Group, Fhir::Device, Fhir::Substance]

  # Accession Identifier
  attribute :accession_identifiers, Array[Fhir::Identifier] # Identifier

  # Received Time
  attribute :received_time, DateTime # dateTime

  # Details concerning the specimen collection.
  class Collection < Fhir::ValueObject
    # Who collected the specimen
    resource_reference :collector, [Fhir::Practitioner]

    # Collector comments
    attribute :comments, Array[String] # string

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
    resource_references :additives, [Fhir::Substance]
  end

  attribute :treatments, Array[Treatment] # 

  # The container holding the specimen. May be recursive; ie
  # blood in tube in tray in rack.
  class Container < Fhir::ValueObject
    # Id for container
    # Should be present
    attribute :identifiers, Array[Fhir::Identifier] # Identifier

    # Textual description of container
    attribute :description, String # string

    # Specimen Container Type
    attribute :type, Fhir::CodeableConcept # CodeableConcept

    # Container Capacity
    attribute :capacity, Fhir::Quantity # Quantity

    # Specimen Container Quantity
    attribute :specimen_quantity, Fhir::Quantity # Quantity

    # Container Additive
    resource_reference :additive, [Fhir::Substance]
  end

  attribute :containers, Array[Container] # 
end

