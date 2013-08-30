# Describes the set of data produced by a device.
class Fhir::DeviceCapabilities < Fhir::Resource
  # Additional Content defined by implementations
  attribute :extension, Array[Extension]

  # Text summary of the resource, for human interpretation
  attribute :text, Narrative

  # Contained, inline Resources
  attribute :contained, Array[ResourceLink[Resource]]

  # The name of this device
  attribute :name, string

  # The type of device
  attribute :type, CodeableConcept

  # Company that built the device
  attribute :manufacturer, string

  # Identifies this particular device uniquely
  attribute :identity, ResourceLink[Device]

  # A medical-related subsystem of a medical device.
  class VirtualDevice < Fhir::ValueObject
    # Describes the compartment
    attribute :code, CodeableConcept

    # Groups together physiological measurement data and derived
    # data.
    class Channel < Fhir::ValueObject
      # Describes the channel
      attribute :code, CodeableConcept

      # A piece of measured or derived data that will be reported
      # by the machine.
      class Metric < Fhir::ValueObject
        # Describes the metrics
        # Should be present
        attribute :code, CodeableConcept

        # Used to link to data in device log
        # Should be present
        attribute :key, string

        # How to interpret this metric value.
        class Info < Fhir::ValueObject
          # Quantity | Coding | Array | string
          # Should be present
          attribute :type, code

          # Human Readable units of data value
          attribute :units, string

          # UCUM units for data value
          attribute :ucum, code

          # Array template (fixed values)
          attribute :template, SampledData

          # System for coding
          attribute :system, uri
        end

        # Should be present
        attribute :info, Info

        # Additional data that qualifies the metric, or contributes
        # to its assessment.
        class Facet < Fhir::ValueObject
          # Describes the facet
          # Should be present
          attribute :code, CodeableConcept

          # Factor to apply to raw values (default = 1)
          attribute :scale, decimal

          # Used to link to data in device log
          # Should be present
          attribute :key, string

          # How to interpret this facet value
          # Should be present
          attribute :info, @DeviceCapabilities.virtualDevice.channel.metric.info
        end

        attribute :facet, Array[Facet]
      end

      attribute :metric, Array[Metric]
    end

    attribute :channel, Array[Channel]
  end

  attribute :virtual_device, Array[VirtualDevice]
end

