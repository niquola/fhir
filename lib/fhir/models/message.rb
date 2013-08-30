# The root for a transmission either requesting or
# responding to an action.  The resource(s) that are the
# subject of the action as well as other Information related
# to the action are typically transmitted in a bundle of which
# the Message resource instance is the first resource in the
# bundle.
class Fhir::Message < Fhir::Resource
  # Additional Content defined by implementations
  attribute :extension, Array[Fhir::Extension] # Extension

  # Text summary of the resource, for human interpretation
  attribute :text, Fhir::Narrative # Narrative

  # Contained, inline Resources
  attribute :contained, Array[Fhir::Resource] # Resource

  # Id of this message
  # Should be present
  attribute :identifier, String # id

  # Time that the message was sent
  # Should be present
  attribute :timestamp, DateTime # instant

  # Code for the event this message represents
  # Should be present
  attribute :event, Fhir::Code # code

  # Information about the message that this message is a
  # response to.  Only present if this message is a response.
  class Response < Fhir::ValueObject
    # Id of original message
    # Should be present
    attribute :identifier, String # id

    # Type of response to the message
    # Should be present
    attribute :code, Fhir::Code # code

    # Specific list of hints/warnings/errors
    attribute :details, Fhir::ResourceReference[Fhir::OperationOutcome] # Resource(OperationOutcome)
  end

  attribute :response, Response # 

  # The source application from which this message originated.
  class Source < Fhir::ValueObject
    # Name of system
    attribute :name, String # string

    # Name of software running the system
    # Should be present
    attribute :software, String # string

    # Version of software running
    attribute :version, String # string

    # Human contact for problems
    attribute :contact, Fhir::Contact # Contact

    # Actual message source address or id
    # Should be present
    attribute :endpoint, Fhir::URI # uri
  end

  # Should be present
  attribute :source, Source # 

  # The destination application which the message is intended
  # for.
  class Destination < Fhir::ValueObject
    # Name of system
    attribute :name, String # string

    # Particular delivery destination within the destination
    attribute :target, Fhir::ResourceReference[Fhir::Device] # Resource(Device)

    # Actual destination address or id
    # Should be present
    attribute :endpoint, Fhir::URI # uri
  end

  # Should be present
  attribute :destination, Destination # 

  # The source of the data entry
  attribute :enterer, Fhir::ResourceReference[Fhir::Practitioner] # Resource(Practitioner)

  # The source of the decision
  attribute :author, Fhir::ResourceReference[Fhir::Practitioner] # Resource(Practitioner)

  # Intended "real-world" recipient for the data
  attribute :receiver, Fhir::ResourceReference[Fhir::Practitioner, Fhir::Organization] # Resource(Practitioner|Organization)

  # Final responsibility for event
  attribute :responsible, Fhir::ResourceReference[Fhir::Practitioner, Fhir::Organization] # Resource(Practitioner|Organization)

  # Time of effect
  attribute :effective, Fhir::Period # Period

  # Cause of event
  attribute :reason, Fhir::CodeableConcept # CodeableConcept

  # The actual content of the message
  attribute :data, Array[Fhir::ResourceReference] # Resource(Any)
end

