# A record of an event made for purposes of maintaining a
# security log. Typical uses include detection of intrusion
# attempts and monitoring for inappropriate usage.
class Fhir::SecurityEvent < Fhir::Resource
  # Additional Content defined by implementations
  attribute :extension, Array[Extension]

  # Text summary of the resource, for human interpretation
  attribute :text, Narrative

  # Contained, inline Resources
  attribute :contained, Array[ResourceLink[Resource]]

  # Identifies the name, action type, time, and disposition of
  # the audited event.
  class Event < Fhir::ValueObject
    # Type of event
    # Should be present
    attribute :type, CodeableConcept

    # Sub-type of event
    attribute :subtype, Array[CodeableConcept]

    # Type of action performed during the event
    attribute :action, code

    # Time when the event occurred on source
    # Should be present
    attribute :date_time, instant

    # Whether the event succeeded or failed
    attribute :outcome, code

    # Description of the event outcome
    attribute :outcome_desc, string
  end

  # Should be present
  attribute :event, Event

  # A person, a hardware device or software process.
  class Participant < Fhir::ValueObject
    # User roles (e.g. local RBAC codes)
    attribute :role, Array[CodeableConcept]

    # Direct reference to resource
    attribute :reference, ResourceLink[Practitioner, Patient, Device]

    # Unique identifier for the user
    attribute :user_id, string

    # User id used by authentication system
    attribute :auth_id, string

    # Human-meaningful name for the user
    attribute :name, string

    # Whether user is initiator
    # Should be present
    attribute :requestor, boolean

    # Type of media
    attribute :media, Coding

    # Logical network location for application activity, if the
    # activity has a network location.
    class Network < Fhir::ValueObject
      # Identifier for the network access point of the user device
      attribute :identifier, string

      # The type of network access point
      attribute :type, code
    end

    attribute :network, Network
  end

  # Should be present
  attribute :participant, Array[Participant]

  # Application systems and processes.
  class Source < Fhir::ValueObject
    # Logical source location within the enterprise
    attribute :site, string

    # The id of source where event originated
    # Should be present
    attribute :identifier, string

    # The type of source where event originated
    attribute :type, Array[Coding]
  end

  # Should be present
  attribute :source, Source

  # Specific instances of data or objects that have been
  # accessed.
  class Object < Fhir::ValueObject
    # Specific instance of object (e.g. versioned)
    attribute :identifier, Identifier

    # Specific instance of resource (e.g. versioned)
    attribute :reference, ResourceLink[Any]

    # Object type being audited
    attribute :type, code

    # Functional application role of Object
    attribute :role, code

    # Life-cycle stage for the object
    attribute :lifecycle, code

    # Policy-defined sensitivity for the object
    attribute :sensitivity, CodeableConcept

    # Instance-specific descriptor for Object
    attribute :name, string

    # Actual query for object
    attribute :query, base64Binary

    # Additional Information about the Object.
    class Detail < Fhir::ValueObject
      # Name of the property
      # Should be present
      attribute :type, string

      # Property value
      # Should be present
      attribute :value, base64Binary
    end

    attribute :detail, Array[Detail]
  end

  attribute :object, Array[Object]
end

