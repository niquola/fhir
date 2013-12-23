# A record of an event made for purposes of maintaining a
# security log. Typical uses include detection of intrusion
# attempts and monitoring for inappropriate usage.
class Fhir::SecurityEvent < Fhir::Resource
  invariants do
    validates_presence_of :event
    validates_presence_of :participant
    validates_presence_of :source
  end

  # Extensions that cannot be ignored
  attribute :modifier_extension, Array[Fhir::Extension]

  # Text summary of the resource, for human interpretation
  attribute :text, Fhir::Narrative

  # Identifies the name, action type, time, and disposition of
  # the audited event.
  class Event < Fhir::ValueObject
    invariants do
      validates_presence_of :type
      validates_presence_of :date_time
    end

    # Extensions that cannot be ignored
    attribute :modifier_extension, Array[Fhir::Extension]

    # Type/identifier of event
    attribute :type, Fhir::CodeableConcept

    # More specific type/id for the event
    attribute :subtype, Array[Fhir::CodeableConcept]

    # Type of action performed during the event
    attribute :action, Fhir::Code

    # Time when the event occurred on source
    attribute :date_time, DateTime

    # Whether the event succeeded or failed
    attribute :outcome, Fhir::Code

    # Description of the event outcome
    attribute :outcome_desc, String
  end

  attribute :event, Event

  # A person, a hardware device or software process.
  class Participant < Fhir::ValueObject
    invariants do
      validates_inclusion_of :requestor, in: [true, false], message: 'must be either true or false'
    end

    # Extensions that cannot be ignored
    attribute :modifier_extension, Array[Fhir::Extension]

    # User roles (e.g. local RBAC codes)
    attribute :role, Array[Fhir::CodeableConcept]

    # Direct reference to resource
    resource_reference :reference, [Fhir::Practitioner, Fhir::Patient, Fhir::Device]

    # Unique identifier for the user
    attribute :user_id, String

    # Alternative User id e.g. authentication
    attribute :alt_id, String

    # Human-meaningful name for the user
    attribute :name, String

    # Whether user is initiator
    attribute :requestor, Boolean

    # Type of media
    attribute :media, Fhir::Coding

    # Logical network location for application activity, if the
    # activity has a network location.
    class Network < Fhir::ValueObject
      # Extensions that cannot be ignored
      attribute :modifier_extension, Array[Fhir::Extension]

      # Identifier for the network access point of the user device
      attribute :identifier, String

      # The type of network access point
      attribute :type, Fhir::Code
    end

    attribute :network, Network
  end

  attribute :participant, Array[Participant]

  # Application systems and processes.
  class Source < Fhir::ValueObject
    invariants do
      validates_presence_of :identifier
    end

    # Extensions that cannot be ignored
    attribute :modifier_extension, Array[Fhir::Extension]

    # Logical source location within the enterprise
    attribute :site, String

    # The id of source where event originated
    attribute :identifier, String

    # The type of source where event originated
    attribute :type, Array[Fhir::Coding]
  end

  attribute :source, Source

  # Specific instances of data or objects that have been
  # accessed.
  class Object < Fhir::ValueObject
    # Extensions that cannot be ignored
    attribute :modifier_extension, Array[Fhir::Extension]

    # Specific instance of object (e.g. versioned)
    attribute :identifier, Fhir::Identifier

    # Specific instance of resource (e.g. versioned)
    resource_reference :reference, [Fhir::Resource]

    # Object type being audited
    attribute :type, Fhir::Code

    # Functional application role of Object
    attribute :role, Fhir::Code

    # Life-cycle stage for the object
    attribute :lifecycle, Fhir::Code

    # Policy-defined sensitivity for the object
    attribute :sensitivity, Fhir::CodeableConcept

    # Instance-specific descriptor for Object
    attribute :name, String

    # Descriptive text
    attribute :description, String

    # Actual query for object
    attribute :query, String

    # Additional Information about the Object.
    class Detail < Fhir::ValueObject
      invariants do
        validates_presence_of :type
        validates_presence_of :value
      end

      # Extensions that cannot be ignored
      attribute :modifier_extension, Array[Fhir::Extension]

      # Name of the property
      attribute :type, String

      # Property value
      attribute :value, String
    end

    attribute :detail, Array[Detail]
  end

  attribute :object, Array[Object]
end


Fhir.load_extension('security_event')
