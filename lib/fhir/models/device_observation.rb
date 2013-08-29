class DeviceObservation
  include Virtus
  # Additional Content defined by implementations
  attribute :extension, Extension

  # Text summary of the resource, for human interpretation
  attribute :text, Narrative

  # Contained, inline Resources
  attribute :contained, Resource

  # Type of device observation
  attribute :code, CodeableConcept

  # Identifiers assigned to this observation
  attribute :identifier, Identifier

  # Date the measurements were made
  attribute :issued, instant

  # The subject of the measurements
  attribute :subject, Resource(Patient|Group|Device)

  # Device that produced the results
  attribute :device, Resource(Device)

  # Actual measurements
  attribute :measurement, Resource(Observation)

end
