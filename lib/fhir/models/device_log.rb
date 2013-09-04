# A set of raw data produced by a device.
class Fhir::DeviceLog < Fhir::Resource
  # When the data values are reported
  attribute :instant, DateTime

  # Explicit reference to the capabilities
  resource_reference :capabilities, [Fhir::DeviceCapabilities]

  # Subject of the measurement
  resource_reference :subject, [Fhir::Patient, Fhir::Group, Fhir::Device]

  # An item of data that the device produces.
  class Item < Fhir::ValueObject
    # Reference to device capabilities declaration
    # Should be present
    attribute :key, String

    # The value of the data item, if available
    attribute :value, String

    # Information about the quality of the data etc
    attribute :flags, Array[Fhir::Code]
  end

  attribute :items, Array[Item]
end

