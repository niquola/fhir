# A set of raw data produced by a device.
class Fhir::DeviceLog < Fhir::Resource
  # Additional Content defined by implementations
  attribute :extensions, Array[Fhir::Extension] # Extension

  # Text summary of the resource, for human interpretation
  attribute :text, Fhir::Narrative # Narrative

  # Contained, inline Resources
  attribute :containeds, Array[Fhir::Resource] # Resource

  # When the data values are reported
  attribute :instant, DateTime # instant

  # Explicit reference to the capabilities
  attribute :capabilities, Fhir::ResourceReference[Fhir::DeviceCapabilities] # Resource(DeviceCapabilities)

  # Subject of the measurement
  attribute :subject, Fhir::ResourceReference[Fhir::Patient, Fhir::Group, Fhir::Device] # Resource(Patient|Group|Device)

  # An item of data that the device produces.
  class Item < Fhir::ValueObject
    # Reference to device capabilities declaration
    # Should be present
    attribute :key, String # string

    # The value of the data item, if available
    attribute :value, String # string

    # Information about the quality of the data etc
    attribute :flags, Array[Fhir::Code] # code
  end

  attribute :items, Array[Item] # 
end

