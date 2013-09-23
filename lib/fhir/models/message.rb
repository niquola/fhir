# The root for a transmission either requesting or
# responding to an action.  The resource(s) that are the
# subject of the action as well as other Information related
# to the action are typically transmitted in a bundle of which
# the Message resource instance is the first resource in the
# bundle.
class Fhir::Message < Fhir::Resource
  invariants do
    validates_presence_of :identifier
    validates_presence_of :timestamp
    validates_presence_of :event
    validates_presence_of :source
    validates_presence_of :destination
  end

  # Text summary of the resource, for human interpretation
  attribute :text, Fhir::Narrative

  # Id of this message
  attribute :identifier, String

  # Time that the message was sent
  attribute :timestamp, DateTime

  # Code for the event this message represents
  attribute :event, Fhir::Code

  # Information about the message that this message is a
  # response to.  Only present if this message is a response.
  class Response < Fhir::ValueObject
    invariants do
      validates_presence_of :identifier
      validates_presence_of :code
    end

    # Id of original message
    attribute :identifier, String

    # Type of response to the message
    attribute :code, Fhir::Code

    # Specific list of hints/warnings/errors
    resource_reference :details, [Fhir::OperationOutcome]
  end

  attribute :response, Response

  # The source application from which this message originated.
  class Source < Fhir::ValueObject
    invariants do
      validates_presence_of :software
      validates_presence_of :endpoint
    end

    # Name of system
    attribute :name, String

    # Name of software running the system
    attribute :software, String

    # Version of software running
    attribute :version, String

    # Human contact for problems
    attribute :contact, Fhir::Contact

    # Actual message source address or id
    attribute :endpoint, Fhir::URI
  end

  attribute :source, Source

  # The destination application which the message is intended
  # for.
  class Destination < Fhir::ValueObject
    invariants do
      validates_presence_of :endpoint
    end

    # Name of system
    attribute :name, String

    # Particular delivery destination within the destination
    resource_reference :target, [Fhir::Device]

    # Actual destination address or id
    attribute :endpoint, Fhir::URI
  end

  attribute :destination, Destination

  # The source of the data entry
  resource_reference :enterer, [Fhir::Practitioner]

  # The source of the decision
  resource_reference :author, [Fhir::Practitioner]

  # Intended "real-world" recipient for the data
  resource_reference :receiver, [Fhir::Practitioner, Fhir::Organization]

  # Final responsibility for event
  resource_reference :responsible, [Fhir::Practitioner, Fhir::Organization]

  # Time of effect
  attribute :effective, Fhir::Period

  # Cause of event
  attribute :reason, Fhir::CodeableConcept

  # The actual content of the message
  resource_references :data, [Fhir::Resource]
end


Fhir.load_extension('message')
