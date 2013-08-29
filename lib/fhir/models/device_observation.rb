class DeviceObservation
  attribute :extension, Extension
  attribute :text, Narrative
  attribute :contained, Resource
  attribute :code, CodeableConcept
  attribute :identifier, Identifier
  attribute :issued, instant
  attribute :subject, Resource(Patient|Group|Device)
  attribute :device, Resource(Device)
  attribute :measurement, Resource(Observation)
end
