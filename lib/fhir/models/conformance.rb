# A conformance statement about how an application or
# implementation supports FHIR or the set of requirements for
# a desired implementation.
class Fhir::Conformance < Fhir::Resource
  invariants do
    validates_presence_of :publisher
    validates_presence_of :date
    validates_presence_of :fhir_version
    validates_inclusion_of :accept_unknown, in: [true, false], message: 'must be either true or false'
    validates_presence_of :format
  end

  # Extensions that cannot be ignored
  attribute :modifier_extension, Array[Fhir::Extension]

  # Text summary of the resource, for human interpretation
  attribute :text, Fhir::Narrative

  # Logical id to reference this statement
  attribute :identifier, String

  # Logical id for this version of the statement
  attribute :version, String

  # Informal name for this conformance statement
  attribute :name, String

  # Publishing Organization
  attribute :publisher, String

  # Contacts for Organization
  attribute :telecom, Array[Fhir::Contact]

  # Human description of the conformance statement
  attribute :description, String

  # draft | active | retired
  attribute :status, Fhir::Code

  # If for testing purposes, not real usage
  attribute :experimental, Boolean

  # Publication Date
  attribute :date, DateTime

  # Describes the software that is covered by this conformance
  # statement.  Used when the profile describes the capabilities
  # of a particular software version, independent of an
  # installation.
  class Software < Fhir::ValueObject
    invariants do
      validates_presence_of :name
    end

    # Extensions that cannot be ignored
    attribute :modifier_extension, Array[Fhir::Extension]

    # Name software is known by
    attribute :name, String

    # Version covered by this statement
    attribute :version, String

    # Date this version released
    attribute :release_date, DateTime
  end

  attribute :software, Software

  # Used when the statement describes the capabilities of a
  # specific implementation instance - i.e. a particular
  # installation, rather than the capabilities of a software
  # program.
  class Implementation < Fhir::ValueObject
    invariants do
      validates_presence_of :description
    end

    # Extensions that cannot be ignored
    attribute :modifier_extension, Array[Fhir::Extension]

    # Describes this specific instance
    attribute :description, String

    # Base URL for the installation
    attribute :url, Fhir::URI
  end

  attribute :implementation, Implementation

  # FHIR Version
  attribute :fhir_version, String

  # True if application accepts unknown elements
  attribute :accept_unknown, Boolean

  # formats supported (xml | json | mime type)
  attribute :format, Array[Fhir::Code]

  # Profiles supported by the system
  resource_references :profile, [Fhir::Profile]

  # Defines the restful capabilities of the solution, if any.
  class Rest < Fhir::ValueObject
    invariants do
      validates_presence_of :mode
      validates_presence_of :resource
    end

    # Extensions that cannot be ignored
    attribute :modifier_extension, Array[Fhir::Extension]

    # client | server
    attribute :mode, Fhir::Code

    # General description of implementation
    attribute :documentation, String

    # Information about security of implementation.
    class Security < Fhir::ValueObject
      # Extensions that cannot be ignored
      attribute :modifier_extension, Array[Fhir::Extension]

      # Adds CORS Headers (http://enable-cors.org/)
      attribute :cors, Boolean

      # OAuth | OAuth2 | NTLM | Basic | Kerberos
      attribute :service, Array[Fhir::CodeableConcept]

      # General description of how security works
      attribute :description, String

      # Certificates associated with security profiles.
      class Certificate < Fhir::ValueObject
        # Extensions that cannot be ignored
        attribute :modifier_extension, Array[Fhir::Extension]

        # Mime type for certificate
        attribute :type, Fhir::Code

        # Actual certificate
        attribute :blob, String
      end

      attribute :certificate, Array[Certificate]
    end

    attribute :security, Security

    # Identifies the restful capabilities of the solution for a
    # specific resource type.
    class Resource < Fhir::ValueObject
      invariants do
        validates_presence_of :type
        validates_presence_of :operation
      end

      # Extensions that cannot be ignored
      attribute :modifier_extension, Array[Fhir::Extension]

      # A resource type that is supported
      attribute :type, Fhir::Code

      # What structural features are supported
      resource_reference :profile, [Fhir::Profile]

      # Identifies a restful operation supported by the solution.
      class Operation < Fhir::ValueObject
        invariants do
          validates_presence_of :code
        end

        # Extensions that cannot be ignored
        attribute :modifier_extension, Array[Fhir::Extension]

        # read | vread | update | delete | history-instance |
        # validate | history-type | create | search-type
        attribute :code, Fhir::Code

        # Anything special about operation behavior
        attribute :documentation, String
      end

      attribute :operation, Array[Operation]

      # Whether vRead can return past versions
      attribute :read_history, Boolean

      # If allows/uses update to a new location
      attribute :update_create, Boolean

      # _include values supported by the server
      attribute :search_include, Array[String]

      # Defines additional search parameters for implementations
      # to support and/or make use of.
      class SearchParam < Fhir::ValueObject
        invariants do
          validates_presence_of :name
          validates_presence_of :type
          validates_presence_of :documentation
        end

        # Extensions that cannot be ignored
        attribute :modifier_extension, Array[Fhir::Extension]

        # Name of search parameter
        attribute :name, String

        # Source of definition
        attribute :source, Fhir::URI

        # number | date | string | token | reference | composite
        attribute :type, Fhir::Code

        # Contents and meaning of search parameter
        attribute :documentation, String

        # XPath that extracts the parameter set
        attribute :xpath, String

        # Types of resource (if a resource reference)
        attribute :target, Array[Fhir::Code]

        # Chained names supported
        attribute :chain, Array[String]
      end

      attribute :search_param, Array[SearchParam]
    end

    attribute :resource, Array[Resource]

    # Identifies a restful operation supported by the solution.
    class Operation < Fhir::ValueObject
      invariants do
        validates_presence_of :code
      end

      # Extensions that cannot be ignored
      attribute :modifier_extension, Array[Fhir::Extension]

      # transaction | search-system | history-system
      attribute :code, Fhir::Code

      # Anything special about operation behavior
      attribute :documentation, String
    end

    attribute :operation, Array[Operation]

    # Definition of a named query and its parameters and their
    # meaning.
    class Query < Fhir::ValueObject
      invariants do
        validates_presence_of :name
        validates_presence_of :documentation
      end

      # Extensions that cannot be ignored
      attribute :modifier_extension, Array[Fhir::Extension]

      # Special named queries (_query=)
      attribute :name, String

      # Describes the named query
      attribute :documentation, String

      # Parameter for the named query
      attribute :parameter, Array[Fhir::Conformance::Rest::Resource::SearchParam]
    end

    attribute :query, Array[Query]

    # How documents are accepted in /Mailbox
    attribute :document_mailbox, Array[Fhir::URI]
  end

  attribute :rest, Array[Rest]

  # Describes the messaging capabilities of the solution.
  class Messaging < Fhir::ValueObject
    invariants do
      validates_presence_of :event
    end

    # Extensions that cannot be ignored
    attribute :modifier_extension, Array[Fhir::Extension]

    # Actual endpoint being described
    attribute :endpoint, Fhir::URI

    # Reliable Message Cache Length
    attribute :reliable_cache, Integer

    # Messaging interface behavior details
    attribute :documentation, String

    # Describes the solution's support for an event at this end
    # point.
    class Event < Fhir::ValueObject
      invariants do
        validates_presence_of :code
        validates_presence_of :mode
        validates_presence_of :focus
        validates_presence_of :request_ref
        validates_presence_of :response_ref
      end

      # Extensions that cannot be ignored
      attribute :modifier_extension, Array[Fhir::Extension]

      # Event type
      attribute :code, Fhir::Coding

      # Consequence | Currency | Notification
      attribute :category, Fhir::Code

      # sender | receiver
      attribute :mode, Fhir::Code

      # http | ftp | mllp +
      attribute :protocol, Array[Fhir::Coding]

      # Resource that's focus of message
      attribute :focus, Fhir::Code

      # Profile that describes the request
      resource_reference :request, [Fhir::Profile]

      # Profile that describes the response
      resource_reference :response, [Fhir::Profile]

      # Endpoint-specific event documentation
      attribute :documentation, String
    end

    attribute :event, Array[Event]
  end

  attribute :messaging, Array[Messaging]

  # A document definition.
  class Document < Fhir::ValueObject
    invariants do
      validates_presence_of :mode
      validates_presence_of :profile_ref
    end

    # Extensions that cannot be ignored
    attribute :modifier_extension, Array[Fhir::Extension]

    # producer | consumer
    attribute :mode, Fhir::Code

    # Description of document support
    attribute :documentation, String

    # Constraint on a resource used in the document
    resource_reference :profile, [Fhir::Profile]
  end

  attribute :document, Array[Document]
end


Fhir.load_extension('conformance')
