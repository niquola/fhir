# A set of observations produced by a device.
class Fhir::DeviceObservation < Fhir::Resource
  # Additional Content defined by implementations
  attribute :extension, Array[Fhir::Extension] # Extension

  # Text summary of the resource, for human interpretation
  attribute :text, Fhir::Narrative # Narrative

  # Contained, inline Resources
  attribute :contained, Array[Fhir::Resource] # Resource

  # Type of device observation
  # Should be present
  attribute :code, Fhir::CodeableConcept # CodeableConcept

  # Identifiers assigned to this observation
  attribute :identifier, Array[Fhir::Identifier] # Identifier

  # Date the measurements were made
  # Should be present
  attribute :issued, DateTime # instant

  # The subject of the measurements
  # Should be present
  attribute :subject, Fhir::ResourceReference[Fhir::Patient, Fhir::Group, Fhir::Device] # Resource(Patient|Group|Device)

  # Device that produced the results
  # Should be present
  attribute :device, Fhir::ResourceReference[Fhir::Device] # Resource(Device)

  # Actual measurements
  attribute :measurement, Array[Fhir::ResourceReference[Fhir::Observation]] # Resource(Observation)
end

