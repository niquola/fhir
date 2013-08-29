class Message
  include Virtus
  # Additional Content defined by implementations
  attribute :extension, Extension

  # Text summary of the resource, for human interpretation
  attribute :text, Narrative

  # Contained, inline Resources
  attribute :contained, Resource

  # Id of this message
  attribute :identifier, id

  # Time that the message was sent
  attribute :timestamp, instant

  # Code for the event this message represents
  attribute :event, code

  # If this is a reply to prior message
  attribute :response, Response

  class Response
    include Virtus::ValueObject
    # Id of original message
    attribute :identifier, id

    # Type of response to the message
    attribute :code, code

    # Specific list of hints/warnings/errors
    attribute :details, Resource(OperationOutcome)

  end
  # Message Source Application
  attribute :source, Source

  class Source
    include Virtus::ValueObject
    # Name of system
    attribute :name, String

    # Name of software running the system
    attribute :software, String

    # Version of software running
    attribute :version, String

    # Human contact for problems
    attribute :contact, Contact

    # Actual message source address or id
    attribute :endpoint, uri

  end
  # Message Destination Application
  attribute :destination, Destination

  class Destination
    include Virtus::ValueObject
    # Name of system
    attribute :name, String

    # Particular delivery destination within the destination
    attribute :target, Resource(Device)

    # Actual destination address or id
    attribute :endpoint, uri

  end
  # The source of the data entry
  attribute :enterer, Resource(Practitioner)

  # The source of the decision
  attribute :author, Resource(Practitioner)

  # Intended "real-world" recipient for the data
  attribute :receiver, Resource(Practitioner|Organization)

  # Final responsibility for event
  attribute :responsible, Resource(Practitioner|Organization)

  # Time of effect
  attribute :effective, Period

  # Cause of event
  attribute :reason, CodeableConcept

  # The actual content of the message
  attribute :data, Resource(Any)

end
