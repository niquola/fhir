# A set of raw data produced by a device
class DeviceLog
  include Virtus
  # Additional Content defined by implementations
  attribute :extension, Extension

  # Text summary of the resource, for human interpretation
  attribute :text, Narrative

  # Contained, inline Resources
  attribute :contained, Resource

  # When the data values are reported
  attribute :instant, instant

  # Explicit reference to the capabilities
  attribute :capabilities, Resource(DeviceCapabilities)

  # Subject of the measurement
  attribute :subject, Resource(Patient|Group|Device)

  # An item of data
  attribute :item, Item

  class Item
    include Virtus::ValueObject
    # Reference to device capabilities declaration
    attribute :key, String

    # The value of the data item, if available
    attribute :value, String

    # Information about the quality of the data etc
    attribute :flag, code

  end
end
