class DeviceCapabilities
  include Virtus
  # Additional Content defined by implementations
  attribute :extension, Extension

  # Text summary of the resource, for human interpretation
  attribute :text, Narrative

  # Contained, inline Resources
  attribute :contained, Resource

  # The name of this device
  attribute :name, String

  # The type of device
  attribute :type, CodeableConcept

  # Company that built the device
  attribute :manufacturer, String

  # Identifies this particular device uniquely
  attribute :identity, Resource(Device)

  # A medical-related subsystem of a medical device
  attribute :virtualDevice, VirtualDevice

  class VirtualDevice
    include Virtus::ValueObject
    # Describes the compartment
    attribute :code, CodeableConcept

    # Groups related data items
    attribute :channel, Channel

    class Channel
      include Virtus::ValueObject
      # Describes the channel
      attribute :code, CodeableConcept

      # Piece of data reported by device
      attribute :metric, Metric

      class Metric
        include Virtus::ValueObject
        # Describes the metrics
        attribute :code, CodeableConcept

        # Used to link to data in device log
        attribute :key, String

        # How to interpret this metric value
        attribute :info, Info

        class Info
          include Virtus::ValueObject
          # Quantity | Coding | Array | string
          attribute :type, code

          # Human Readable units of data value
          attribute :units, String

          # UCUM units for data value
          attribute :ucum, code

          # Array template (fixed values)
          attribute :template, SampledData

          # System for coding
          attribute :system, uri

        end
        # Additional clarifying or qualifiying data
        attribute :facet, Facet

        class Facet
          include Virtus::ValueObject
          # Describes the facet
          attribute :code, CodeableConcept

          # Factor to apply to raw values (default = 1)
          attribute :scale, decimal

          # Used to link to data in device log
          attribute :key, String

          # How to interpret this facet value
          attribute :info, @DeviceCapabilities.virtualDevice.channel.metric.info

        end
      end
    end
  end
end
