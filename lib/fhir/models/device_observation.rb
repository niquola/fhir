# A set of observations produced by a device.
class Fhir::DeviceObservation < Fhir::Resource
  # Additional Content defined by implementations
  attribute :extension, Array[Extension]

  # Text summary of the resource, for human interpretation
  attribute :text, Narrative

  # Contained, inline Resources
  attribute :contained, Array[ResourceLink[Resource]]

  # Type of device observation
  # Should be present
  attribute :code, CodeableConcept

  # Identifiers assigned to this observation
  attribute :identifier, Array[Identifier]

  # Date the measurements were made
  # Should be present
  attribute :issued, instant

  # The subject of the measurements
  # Should be present
  attribute :subject, ResourceLink[Patient, Group, Device]

  # Device that produced the results
  # Should be present
  attribute :device, ResourceLink[Device]

  # Actual measurements
  attribute :measurement, Array[ResourceLink[Observation]]
end

