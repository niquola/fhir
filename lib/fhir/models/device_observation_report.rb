# Describes the data produced by a device at a point in
# time.
class Fhir::DeviceObservationReport < Fhir::Resource
  invariants do
    validates_presence_of :instant
    validates_presence_of :source_ref
  end

  # Extensions that cannot be ignored
  attribute :modifier_extension, Array[Fhir::Extension]

  # Text summary of the resource, for human interpretation
  attribute :text, Fhir::Narrative

  # When the data values are reported
  attribute :instant, DateTime

  # As assigned by the source device
  attribute :identifier, Fhir::Identifier

  # Identifies/describes where the data came from
  resource_reference :source, [Fhir::Device]

  # Subject of the measurement
  resource_reference :subject, [Fhir::Patient, Fhir::Device, Fhir::Location]

  # A medical-related subsystem of a medical device.
  class VirtualDevice < Fhir::ValueObject
    # Extensions that cannot be ignored
    attribute :modifier_extension, Array[Fhir::Extension]

    # Describes the compartment
    attribute :code, Fhir::CodeableConcept

    # Groups together physiological measurement data and derived
    # data.
    class Channel < Fhir::ValueObject
      # Extensions that cannot be ignored
      attribute :modifier_extension, Array[Fhir::Extension]

      # Describes the channel
      attribute :code, Fhir::CodeableConcept

      # A piece of measured or derived data that is reported by
      # the machine.
      class Metric < Fhir::ValueObject
        invariants do
          validates_presence_of :observation_ref
        end

        # Extensions that cannot be ignored
        attribute :modifier_extension, Array[Fhir::Extension]

        # The data for the metric
        resource_reference :observation, [Fhir::Observation]
      end

      attribute :metric, Array[Metric]
    end

    attribute :channel, Array[Channel]
  end

  attribute :virtual_device, Array[VirtualDevice]
end


Fhir.load_extension('device_observation_report')
