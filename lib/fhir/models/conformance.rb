class Conformance
  attribute :extension, Extension
  attribute :text, Narrative
  attribute :contained, Resource
  attribute :identifier, String
  attribute :version, String
  attribute :name, String
  attribute :publisher, String
  attribute :telecom, Contact
  attribute :description, String
  attribute :status, code
  attribute :experimental, boolean
  attribute :date, DateTime
  attribute :software, Software
  class Software
    attribute :name, String
    attribute :version, String
    attribute :releaseDate, DateTime
  end
  attribute :implementation, Implementation
  class Implementation
    attribute :description, String
    attribute :url, uri
  end
  attribute :fhirVersion, id
  attribute :acceptUnknown, boolean
  attribute :format, code
  attribute :rest, Rest
  class Rest
    attribute :mode, code
    attribute :documentation, String
    attribute :security, Security
    class Security
      attribute :service, CodeableConcept
      attribute :description, String
      attribute :certificate, Certificate
      class Certificate
        attribute :type, code
        attribute :blob, base64Binary
      end
    end
    attribute :resource, Resource
    class Resource
      attribute :type, code
      attribute :profile, Resource(Profile)
      attribute :operation, Operation
      class Operation
        attribute :code, code
        attribute :documentation, String
      end
      attribute :readHistory, boolean
      attribute :searchInclude, String
      attribute :searchParam, SearchParam
      class SearchParam
        attribute :name, String
        attribute :source, uri
        attribute :type, code
        attribute :documentation, String
        attribute :xpath, String
        attribute :target, code
        attribute :chain, String
      end
    end
    attribute :batch, boolean
    attribute :history, boolean
    attribute :query, Query
    class Query
      attribute :name, String
      attribute :documentation, String
      attribute :parameter, @Conformance.rest.resource.searchParam
    end
  end
  attribute :messaging, Messaging
  class Messaging
    attribute :endpoint, uri
    attribute :reliableCache, integer
    attribute :documentation, String
    attribute :event, Event
    class Event
      attribute :code, code
      attribute :mode, code
      attribute :protocol, Coding
      attribute :focus, code
      attribute :request, Resource(Profile)
      attribute :response, Resource(Profile)
      attribute :documentation, String
    end
  end
  attribute :document, Document
  class Document
    attribute :mode, code
    attribute :documentation, String
    attribute :profile, Resource(Profile)
  end
end
