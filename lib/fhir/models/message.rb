# The root for a transmission either requesting or
# responding to an action.  The resource(s) that are the
# subject of the action as well as other Information related
# to the action are typically transmitted in a bundle of which
# the Message resource instance is the first resource in the
# bundle.
class Fhir::Message < Fhir::Resource
  # Additional Content defined by implementations
  attribute :extension, Array[Extension]

  # Text summary of the resource, for human interpretation
  attribute :text, Narrative

  # Contained, inline Resources
  attribute :contained, Array[ResourceLink[Resource]]

  # Id of this message
  # Should be present
  attribute :identifier, id

  # Time that the message was sent
  # Should be present
  attribute :timestamp, instant

  # Code for the event this message represents
  # Should be present
  attribute :event, code

  # Information about the message that this message is a
  # response to.  Only present if this message is a response.
  class Response < Fhir::ValueObject
    # Id of original message
    # Should be present
    attribute :identifier, id

    # Type of response to the message
    # Should be present
    attribute :code, code

    # Specific list of hints/warnings/errors
    attribute :details, ResourceLink[OperationOutcome]
  end

  attribute :response, Response

  # The source application from which this message originated.
  class Source < Fhir::ValueObject
    # Name of system
    attribute :name, string

    # Name of software running the system
    # Should be present
    attribute :software, string

    # Version of software running
    attribute :version, string

    # Human contact for problems
    attribute :contact, Contact

    # Actual message source address or id
    # Should be present
    attribute :endpoint, uri
  end

  # Should be present
  attribute :source, Source

  # The destination application which the message is intended
  # for.
  class Destination < Fhir::ValueObject
    # Name of system
    attribute :name, string

    # Particular delivery destination within the destination
    attribute :target, ResourceLink[Device]

    # Actual destination address or id
    # Should be present
    attribute :endpoint, uri
  end

  # Should be present
  attribute :destination, Destination

  # The source of the data entry
  attribute :enterer, ResourceLink[Practitioner]

  # The source of the decision
  attribute :author, ResourceLink[Practitioner]

  # Intended "real-world" recipient for the data
  attribute :receiver, ResourceLink[Practitioner, Organization]

  # Final responsibility for event
  attribute :responsible, ResourceLink[Practitioner, Organization]

  # Time of effect
  attribute :effective, Period

  # Cause of event
  attribute :reason, CodeableConcept

  # The actual content of the message
  attribute :data, Array[ResourceLink[Any]]
end

