# Describes the set of data produced by a device.
class Fhir::DeviceCapabilities < Fhir::Resource
  # Text summary of the resource, for human interpretation
  attribute :text, Fhir::Narrative

  # The name of this device
  attribute :name, String

  # The type of device
  attribute :type, Fhir::CodeableConcept

  # Company that built the device
  attribute :manufacturer, String

  # Identifies this particular device uniquely
  resource_reference :identity, [Fhir::Device]

  # A medical-related subsystem of a medical device.
  class VirtualDevice < Fhir::ValueObject
    # Describes the compartment
    attribute :code, Fhir::CodeableConcept

    # Groups together physiological measurement data and derived
    # data.
    class Channel < Fhir::ValueObject
      # Describes the channel
      attribute :code, Fhir::CodeableConcept

      # A piece of measured or derived data that will be reported
      # by the machine.
      class Metric < Fhir::ValueObject
        invariants do
          validates_presence_of :code
          validates_presence_of :key
          validates_presence_of :info
        end

        # Describes the metrics
        attribute :code, Fhir::CodeableConcept

        # Used to link to data in device log
        attribute :key, String

        # How to interpret this metric value.
        class Info < Fhir::ValueObject
          invariants do
            validates_presence_of :type
          end

          # Quantity | Coding | Array | string
          attribute :type, Fhir::Code

          # Human Readable units of data value
          attribute :units, String

          # UCUM units for data value
          attribute :ucum, Fhir::Code

          # Array template (fixed values)
          attribute :template, Fhir::SampledData

          # System for coding
          attribute :system, Fhir::URI
        end

        attribute :info, Info

        # Additional data that qualifies the metric, or contributes
        # to its assessment.
        class Facet < Fhir::ValueObject
          invariants do
            validates_presence_of :code
            validates_presence_of :key
            validates_presence_of :info
          end

          # Describes the facet
          attribute :code, Fhir::CodeableConcept

          # Factor to apply to raw values (default = 1)
          attribute :scale, Float

          # Used to link to data in device log
          attribute :key, String

          # How to interpret this facet value
          attribute :info, Fhir::DeviceCapabilities::VirtualDevice::Channel::Metric::Info
        end

        attribute :facets, Array[Facet]
      end

      attribute :metrics, Array[Metric]
    end

    attribute :channels, Array[Channel]
  end

  attribute :virtual_devices, Array[VirtualDevice]
end


Fhir.load_extension('device_capabilities')
