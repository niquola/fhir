class Message
  attribute :extension, Extension
  attribute :text, Narrative
  attribute :contained, Resource
  attribute :identifier, id
  attribute :timestamp, instant
  attribute :event, code
  attribute :response, Response
  class Response
    attribute :identifier, id
    attribute :code, code
    attribute :details, Resource(OperationOutcome)
  end
  attribute :source, Source
  class Source
    attribute :name, String
    attribute :software, String
    attribute :version, String
    attribute :contact, Contact
    attribute :endpoint, uri
  end
  attribute :destination, Destination
  class Destination
    attribute :name, String
    attribute :target, Resource(Device)
    attribute :endpoint, uri
  end
  attribute :enterer, Resource(Practitioner)
  attribute :author, Resource(Practitioner)
  attribute :receiver, Resource(Practitioner|Organization)
  attribute :responsible, Resource(Practitioner|Organization)
  attribute :effective, Period
  attribute :reason, CodeableConcept
  attribute :data, Resource(Any)
end
