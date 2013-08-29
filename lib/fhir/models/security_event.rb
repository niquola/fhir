class SecurityEvent
  include Virtus
  # Additional Content defined by implementations
  attribute :extension, Extension

  # Text summary of the resource, for human interpretation
  attribute :text, Narrative

  # Contained, inline Resources
  attribute :contained, Resource

  # What was done
  attribute :event, Event

  class Event
    include Virtus::ValueObject
    # Type of event
    attribute :type, CodeableConcept

    # Sub-type of event
    attribute :subtype, CodeableConcept

    # Type of action performed during the event
    attribute :action, code

    # Time when the event occurred on source
    attribute :dateTime, instant

    # Whether the event succeeded or failed
    attribute :outcome, code

    # Description of the event outcome
    attribute :outcomeDesc, String

  end
  # A person, a hardware device or software process
  attribute :participant, Participant

  class Participant
    include Virtus::ValueObject
    # User roles (e.g. local RBAC codes)
    attribute :role, CodeableConcept

    # Direct reference to resource
    attribute :reference, Resource(Practitioner|Patient|Device)

    # Unique identifier for the user
    attribute :userId, String

    # User id used by authentication system
    attribute :authId, String

    # Human-meaningful name for the user
    attribute :name, String

    # Whether user is initiator
    attribute :requestor, boolean

    # Type of media
    attribute :media, Coding

    # Logical network location for application activity
    attribute :network, Network

    class Network
      include Virtus::ValueObject
      # Identifier for the network access point of the user device
      attribute :identifier, String

      # The type of network access point
      attribute :type, code

    end
  end
  # Application systems and processes
  attribute :source, Source

  class Source
    include Virtus::ValueObject
    # Logical source location within the enterprise
    attribute :site, String

    # The id of source where event originated
    attribute :identifier, String

    # The type of source where event originated
    attribute :type, Coding

  end
  # Specific instances of data or objects that have been accessed
  attribute :object, Object

  class Object
    include Virtus::ValueObject
    # Specific instance of object (e.g. versioned)
    attribute :identifier, Identifier

    # Specific instance of resource (e.g. versioned)
    attribute :reference, Resource(Any)

    # Object type being audited
    attribute :type, code

    # Functional application role of Object
    attribute :role, code

    # Life-cycle stage for the object
    attribute :lifecycle, code

    # Policy-defined sensitivity for the object
    attribute :sensitivity, CodeableConcept

    # Instance-specific descriptor for Object
    attribute :name, String

    # Actual query for object
    attribute :query, base64Binary

    # Additional Information about the Object
    attribute :detail, Detail

    class Detail
      include Virtus::ValueObject
      # Name of the property
      attribute :type, String

      # Property value
      attribute :value, base64Binary

    end
  end
end
