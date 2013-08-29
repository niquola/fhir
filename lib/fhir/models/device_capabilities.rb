class DeviceCapabilities
  attribute :extension, Extension
  attribute :text, Narrative
  attribute :contained, Resource
  attribute :name, String
  attribute :type, CodeableConcept
  attribute :manufacturer, String
  attribute :identity, Resource(Device)
  attribute :virtualDevice, VirtualDevice
  class VirtualDevice
    attribute :code, CodeableConcept
    attribute :channel, Channel
    class Channel
      attribute :code, CodeableConcept
      attribute :metric, Metric
      class Metric
        attribute :code, CodeableConcept
        attribute :key, String
        attribute :info, Info
        class Info
          attribute :type, code
          attribute :units, String
          attribute :ucum, code
          attribute :template, SampledData
          attribute :system, uri
        end
        attribute :facet, Facet
        class Facet
          attribute :code, CodeableConcept
          attribute :scale, decimal
          attribute :key, String
          attribute :info, @DeviceCapabilities.virtualDevice.channel.metric.info
        end
      end
    end
  end
end
