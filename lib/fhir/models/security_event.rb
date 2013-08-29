class SecurityEvent
  attribute :extension, Extension
  attribute :text, Narrative
  attribute :contained, Resource
  attribute :event, Event
  class Event
    attribute :type, CodeableConcept
    attribute :subtype, CodeableConcept
    attribute :action, code
    attribute :dateTime, instant
    attribute :outcome, code
    attribute :outcomeDesc, String
  end
  attribute :participant, Participant
  class Participant
    attribute :role, CodeableConcept
    attribute :reference, Resource(Practitioner|Patient|Device)
    attribute :userId, String
    attribute :authId, String
    attribute :name, String
    attribute :requestor, boolean
    attribute :media, Coding
    attribute :network, Network
    class Network
      attribute :identifier, String
      attribute :type, code
    end
  end
  attribute :source, Source
  class Source
    attribute :site, String
    attribute :identifier, String
    attribute :type, Coding
  end
  attribute :object, Object
  class Object
    attribute :identifier, Identifier
    attribute :reference, Resource(Any)
    attribute :type, code
    attribute :role, code
    attribute :lifecycle, code
    attribute :sensitivity, CodeableConcept
    attribute :name, String
    attribute :query, base64Binary
    attribute :detail, Detail
    class Detail
      attribute :type, String
      attribute :value, base64Binary
    end
  end
end
