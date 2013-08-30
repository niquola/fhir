# A set of raw data produced by a device.
class Fhir::DeviceLog < Fhir::Resource
  # Additional Content defined by implementations
  attribute :extension, Array[Extension]

  # Text summary of the resource, for human interpretation
  attribute :text, Narrative

  # Contained, inline Resources
  attribute :contained, Array[ResourceLink[Resource]]

  # When the data values are reported
  attribute :instant, instant

  # Explicit reference to the capabilities
  attribute :capabilities, ResourceLink[DeviceCapabilities]

  # Subject of the measurement
  attribute :subject, ResourceLink[Patient, Group, Device]

  # An item of data that the device produces.
  class Item < Fhir::ValueObject
    # Reference to device capabilities declaration
    # Should be present
    attribute :key, string

    # The value of the data item, if available
    attribute :value, string

    # Information about the quality of the data etc
    attribute :flag, Array[code]
  end

  attribute :item, Array[Item]
end

