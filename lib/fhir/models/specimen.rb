# Sample for analysis.
class Fhir::Specimen < Fhir::Resource
  invariants do
    validates_presence_of :subject_ref
    validates_presence_of :collection
  end

  # Text summary of the resource, for human interpretation
  attribute :text, Fhir::Narrative

  # External Identifier
  attribute :identifier, Fhir::Identifier

  # Type of specimen
  attribute :type, Fhir::CodeableConcept

  # Parent specimen from which the focal specimen was a
  # component.
  class Source < Fhir::ValueObject
    invariants do
      validates_presence_of :relationship
    end

    # parent | child
    attribute :relationship, Fhir::Code

    # The subject of the relationship
    resource_references :targets, [Fhir::Specimen]
  end

  attribute :sources, Array[Source]

  # The subject of the report
  resource_reference :subject, [Fhir::Patient, Fhir::Group, Fhir::Device, Fhir::Substance]

  # Accession Identifier
  attribute :accession_identifiers, Array[Fhir::Identifier]

  # Received Time
  attribute :received_time, DateTime

  # Details concerning the specimen collection.
  class Collection < Fhir::ValueObject
    invariants do
      validates_presence_of :collected_time
    end

    # Who collected the specimen
    resource_reference :collector, [Fhir::Practitioner]

    # Collector comments
    attribute :comments, Array[String]

    # Collection time
    attribute :collected_time, DateTime

    # The quantity of specimen collected
    attribute :quantity, Fhir::Quantity

    # Specimen Collection Method
    attribute :method, Fhir::CodeableConcept

    # Site of the source of the specimen
    attribute :source_site, Fhir::CodeableConcept
  end

  attribute :collection, Collection

  # Details concerning treatment and processing steps for the
  # specimen.
  class Treatment < Fhir::ValueObject
    # Textual description of procedure
    attribute :description, String

    # Specimen Treatment Procedure
    attribute :procedure, Fhir::CodeableConcept

    # Specimen additive
    resource_references :additives, [Fhir::Substance]
  end

  attribute :treatments, Array[Treatment]

  # The container holding the specimen. May be recursive; ie
  # blood in tube in tray in rack.
  class Container < Fhir::ValueObject
    invariants do
      validates_presence_of :identifiers
    end

    # Id for container
    attribute :identifiers, Array[Fhir::Identifier]

    # Textual description of container
    attribute :description, String

    # Specimen Container Type
    attribute :type, Fhir::CodeableConcept

    # Container Capacity
    attribute :capacity, Fhir::Quantity

    # Specimen Container Quantity
    attribute :specimen_quantity, Fhir::Quantity

    # Container Additive
    resource_reference :additive, [Fhir::Substance]
  end

  attribute :containers, Array[Container]
end


Fhir.load_handmade('specimen')
