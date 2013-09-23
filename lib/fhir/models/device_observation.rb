# A set of observations produced by a device.
class Fhir::DeviceObservation < Fhir::Resource
  invariants do
    validates_presence_of :code
    validates_presence_of :issued
    validates_presence_of :subject_ref
    validates_presence_of :device_ref
  end

  # Text summary of the resource, for human interpretation
  attribute :text, Fhir::Narrative

  # Type of device observation
  attribute :code, Fhir::CodeableConcept

  # Identifiers assigned to this observation
  attribute :identifiers, Array[Fhir::Identifier]

  # Date the measurements were made
  attribute :issued, DateTime

  # The subject of the measurements
  resource_reference :subject, [Fhir::Patient, Fhir::Group, Fhir::Device]

  # Device that produced the results
  resource_reference :device, [Fhir::Device]

  # Actual measurements
  resource_references :measurements, [Fhir::Observation]
end


Fhir.load_extension('device_observation')
