# A record of an event made for purposes of maintaining a
# security log. Typical uses include detection of intrusion
# attempts and monitoring for inappropriate usage.
class Fhir::SecurityEvent < Fhir::Resource
  # Identifies the name, action type, time, and disposition of
  # the audited event.
  class Event < Fhir::ValueObject
    # Type of event
    # Should be present
    attribute :type, Fhir::CodeableConcept

    # Sub-type of event
    attribute :subtypes, Array[Fhir::CodeableConcept]

    # Type of action performed during the event
    attribute :action, Fhir::Code

    # Time when the event occurred on source
    # Should be present
    attribute :date_time, DateTime

    # Whether the event succeeded or failed
    attribute :outcome, Fhir::Code

    # Description of the event outcome
    attribute :outcome_desc, String
  end

  # Should be present
  attribute :event, Event

  # A person, a hardware device or software process.
  class Participant < Fhir::ValueObject
    # User roles (e.g. local RBAC codes)
    attribute :roles, Array[Fhir::CodeableConcept]

    # Direct reference to resource
    resource_reference :reference, [Fhir::Practitioner, Fhir::Patient, Fhir::Device]

    # Unique identifier for the user
    attribute :user_id, String

    # User id used by authentication system
    attribute :auth_id, String

    # Human-meaningful name for the user
    attribute :name, String

    # Whether user is initiator
    # Should be present
    attribute :requestor, Boolean

    # Type of media
    attribute :media, Fhir::Coding

    # Logical network location for application activity, if the
    # activity has a network location.
    class Network < Fhir::ValueObject
      # Identifier for the network access point of the user device
      attribute :identifier, String

      # The type of network access point
      attribute :type, Fhir::Code
    end

    attribute :network, Network
  end

  # Should be present
  attribute :participants, Array[Participant]

  # Application systems and processes.
  class Source < Fhir::ValueObject
    # Logical source location within the enterprise
    attribute :site, String

    # The id of source where event originated
    # Should be present
    attribute :identifier, String

    # The type of source where event originated
    attribute :types, Array[Fhir::Coding]
  end

  # Should be present
  attribute :source, Source

  # Specific instances of data or objects that have been
  # accessed.
  class Object < Fhir::ValueObject
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

    # Actual query for object
    attribute :query, String

    # Additional Information about the Object.
    class Detail < Fhir::ValueObject
      # Name of the property
      # Should be present
      attribute :type, String

      # Property value
      # Should be present
      attribute :value, String
    end

    attribute :details, Array[Detail]
  end

  attribute :objects, Array[Object]
end

