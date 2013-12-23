# Sample for analysis.
class Fhir::Specimen < Fhir::Resource
  invariants do
    validates_presence_of :subject_ref
    validates_presence_of :collection
  end

  # Extensions that cannot be ignored
  attribute :modifier_extension, Array[Fhir::Extension]

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

    # Extensions that cannot be ignored
    attribute :modifier_extension, Array[Fhir::Extension]

    # parent | child
    attribute :relationship, Fhir::Code

    # The subject of the relationship
    resource_references :target, [Fhir::Specimen]
  end

  attribute :source, Array[Source]

  # The subject of the report
  resource_reference :subject, [Fhir::Patient, Fhir::Group, Fhir::Device, Fhir::Substance]

  # Accession Identifier
  attribute :accession_identifier, Array[Fhir::Identifier]

  # Received Time
  attribute :received_time, DateTime

  # Details concerning the specimen collection.
  class Collection < Fhir::ValueObject
    invariants do
      validates_presence_of :collected_time
    end

    # Extensions that cannot be ignored
    attribute :modifier_extension, Array[Fhir::Extension]

    # Who collected the specimen
    resource_reference :collector, [Fhir::Practitioner]

    # Collector comments
    attribute :comment, Array[String]

    # Collection time
    attribute :collected_time, DateTime

    # The quantity of specimen collected
    attribute :quantity, Fhir::Quantity

    # Specimen Collection Method
    attribute :method_name, Fhir::CodeableConcept

    # Site of the source of the specimen
    attribute :source_site, Fhir::CodeableConcept
  end

  attribute :collection, Collection

  # Details concerning treatment and processing steps for the
  # specimen.
  class Treatment < Fhir::ValueObject
    # Extensions that cannot be ignored
    attribute :modifier_extension, Array[Fhir::Extension]

    # Textual description of procedure
    attribute :description, String

    # Specimen Treatment Procedure
    attribute :procedure, Fhir::CodeableConcept

    # Specimen additive
    resource_references :additive, [Fhir::Substance]
  end

  attribute :treatment, Array[Treatment]

  # The container holding the specimen. May be recursive; ie
  # blood in tube in tray in rack.
  class Container < Fhir::ValueObject
    invariants do
      validates_presence_of :identifier
    end

    # Extensions that cannot be ignored
    attribute :modifier_extension, Array[Fhir::Extension]

    # Id for container
    attribute :identifier, Array[Fhir::Identifier]

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

  attribute :container, Array[Container]
end


Fhir.load_extension('specimen')
