# A conformance statement
class Conformance
  include Virtus
  # Additional Content defined by implementations
  attribute :extension, Extension

  # Text summary of the resource, for human interpretation
  attribute :text, Narrative

  # Contained, inline Resources
  attribute :contained, Resource

  # Logical id to reference this statement
  attribute :identifier, String

  # Logical id for this version of the statement
  attribute :version, String

  # Informal name for this conformance statement
  attribute :name, String

  # Publishing Organization
  attribute :publisher, String

  # Contacts for Organization
  attribute :telecom, Contact

  # Human description of the conformance statement
  attribute :description, String

  # draft | experimental | review | production | withdrawn | superseded
  attribute :status, code

  # If for testing purposes, not real usage
  attribute :experimental, boolean

  # Publication Date
  attribute :date, DateTime

  # Software that is covered by this conformance statement
  attribute :software, Software

  class Software
    include Virtus::ValueObject
    # Name software is known by
    attribute :name, String

    # Version covered by this statement
    attribute :version, String

    # Date this version released
    attribute :releaseDate, DateTime

  end
  # If this describes a specific instance
  attribute :implementation, Implementation

  class Implementation
    include Virtus::ValueObject
    # Describes this specific instance
    attribute :description, String

    # Base URL for the installation
    attribute :url, uri

  end
  # FHIR Version
  attribute :fhirVersion, id

  # True if application accepts unknown elements
  attribute :acceptUnknown, boolean

  # formats supported (xml | json | mime type)
  attribute :format, code

  # If the endpoint is a RESTful one
  attribute :rest, Rest

  class Rest
    include Virtus::ValueObject
    # client | server
    attribute :mode, code

    # General description of implementation
    attribute :documentation, String

    # Information about security of implementation
    attribute :security, Security

    class Security
      include Virtus::ValueObject
      # What type of security services are supported/required
      attribute :service, CodeableConcept

      # General description of how security works
      attribute :description, String

      # Certificates associated with security profiles
      attribute :certificate, Certificate

      class Certificate
        include Virtus::ValueObject
        # Mime type for certificate
        attribute :type, code

        # Actual certificate
        attribute :blob, base64Binary

      end
    end
    # Resource served on the REST interface
    attribute :resource, Resource

    class Resource
      include Virtus::ValueObject
      # Resource type
      attribute :type, code

      # Resource Profiles supported
      attribute :profile, Resource(Profile)

      # What operations are supported?
      attribute :operation, Operation

      class Operation
        include Virtus::ValueObject
        # read | vread | update | etc.
        attribute :code, code

        # Anything special about operation behavior
        attribute :documentation, String

      end
      # Whether vRead can return past versions
      attribute :readHistory, boolean

      # _include values supported by the server
      attribute :searchInclude, String

      # Additional search params defined
      attribute :searchParam, SearchParam

      class SearchParam
        include Virtus::ValueObject
        # Name of search parameter
        attribute :name, String

        # Source of definition
        attribute :source, uri

        # Type of search parameter
        attribute :type, code

        # Contents and meaning of search parameter
        attribute :documentation, String

        # XPath that extracts the parameter set
        attribute :xpath, String

        # Types of resource (if a resource reference)
        attribute :target, code

        # Chained names supported
        attribute :chain, String

      end
    end
    # If batches are supported
    attribute :batch, boolean

    # If a system wide history list is supported
    attribute :history, boolean

    # Definition of a named query
    attribute :query, Query

    class Query
      include Virtus::ValueObject
      # Name of the query (_query=)
      attribute :name, String

      # Describes the named query
      attribute :documentation, String

      # Parameter for the named query
      attribute :parameter, @Conformance.rest.resource.searchParam

    end
  end
  # If messaging is supported
  attribute :messaging, Messaging

  class Messaging
    include Virtus::ValueObject
    # Actual endpoint being described
    attribute :endpoint, uri

    # Reliable Message Cache Length
    attribute :reliableCache, integer

    # Messaging interface behavior details
    attribute :documentation, String

    # Declare support for this event
    attribute :event, Event

    class Event
      include Virtus::ValueObject
      # Event type
      attribute :code, code

      # sender | receiver
      attribute :mode, code

      # http | ftp |MLLP | etc.
      attribute :protocol, Coding

      # Resource that's focus of message
      attribute :focus, code

      # Profile that describes the request
      attribute :request, Resource(Profile)

      # Profile that describes the response
      attribute :response, Resource(Profile)

      # Endpoint-specific event documentation
      attribute :documentation, String

    end
  end
  # Document definition
  attribute :document, Document

  class Document
    include Virtus::ValueObject
    # producer | consumer
    attribute :mode, code

    # Description of document support
    attribute :documentation, String

    # Constraint on a resource used in the document
    attribute :profile, Resource(Profile)

  end
end
