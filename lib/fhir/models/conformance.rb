# A conformance statement about how an application or
# implementation supports FHIR or the set of requirements for
# a desired implementation.
class Fhir::Conformance < Fhir::Resource
  # Additional Content defined by implementations
  attribute :extension, Array[Fhir::Extension] # Extension

  # Text summary of the resource, for human interpretation
  attribute :text, Fhir::Narrative # Narrative

  # Contained, inline Resources
  attribute :contained, Array[Fhir::Resource] # Resource

  # Logical id to reference this statement
  attribute :identifier, String # string

  # Logical id for this version of the statement
  attribute :version, String # string

  # Informal name for this conformance statement
  attribute :name, String # string

  # Publishing Organization
  # Should be present
  attribute :publisher, String # string

  # Contacts for Organization
  attribute :telecom, Array[Fhir::Contact] # Contact

  # Human description of the conformance statement
  attribute :description, String # string

  # draft | experimental | review | production | withdrawn |
  # superseded
  attribute :status, Fhir::Code # code

  # If for testing purposes, not real usage
  attribute :experimental, Boolean # boolean

  # Publication Date
  # Should be present
  attribute :date, DateTime # dateTime

  # Describes the software that is covered by this conformance
  # statement.  Used when the profile describes the capabilities
  # of a particular software version, independent of an
  # installation.
  class Software < Fhir::ValueObject
    # Name software is known by
    # Should be present
    attribute :name, String # string

    # Version covered by this statement
    attribute :version, String # string

    # Date this version released
    attribute :release_date, DateTime # dateTime
  end

  attribute :software, Software # 

  # Used when the statement describes the capabilities of a
  # specific implementation instance - i.e. a particular
  # installation, rather than the capabilities of a software
  # program.
  class Implementation < Fhir::ValueObject
    # Describes this specific instance
    # Should be present
    attribute :description, String # string

    # Base URL for the installation
    attribute :url, Fhir::URI # uri
  end

  attribute :implementation, Implementation # 

  # FHIR Version
  # Should be present
  attribute :fhir_version, String # id

  # True if application accepts unknown elements
  # Should be present
  attribute :accept_unknown, Boolean # boolean

  # formats supported (xml | json | mime type)
  # Should be present
  attribute :format, Array[Fhir::Code] # code

  # Defines the restful capabilities of the solution, if any.
  class Rest < Fhir::ValueObject
    # client | server
    # Should be present
    attribute :mode, Fhir::Code # code

    # General description of implementation
    attribute :documentation, String # string

    # Information about security of implementation.
    class Security < Fhir::ValueObject
      # What type of security services are supported/required
      attribute :service, Array[Fhir::CodeableConcept] # CodeableConcept

      # General description of how security works
      attribute :description, String # string

      # Certificates associated with security profiles.
      class Certificate < Fhir::ValueObject
        # Mime type for certificate
        attribute :type, Fhir::Code # code

        # Actual certificate
        attribute :blob, String # base64Binary
      end

      attribute :certificate, Array[Certificate] # 
    end

    attribute :security, Security # 

    # Identifies the restful capabilities of the solution for a
    # specific resource type.
    class Resource < Fhir::ValueObject
      # Resource type
      # Should be present
      attribute :type, Fhir::Code # code

      # Resource Profiles supported
      attribute :profile, Fhir::ResourceReference[Fhir::Profile] # Resource(Profile)

      # Identifies a restful operation supported by the solution.
      class Operation < Fhir::ValueObject
        # read | vread | update | etc.
        # Should be present
        attribute :code, Fhir::Code # code

        # Anything special about operation behavior
        attribute :documentation, String # string
      end

      # Should be present
      attribute :operation, Array[Operation] # 

      # Whether vRead can return past versions
      attribute :read_history, Boolean # boolean

      # _include values supported by the server
      attribute :search_include, Array[String] # string

      # Defines additional search parameters for implementations
      # to support and/or make use of.
      class SearchParam < Fhir::ValueObject
        # Name of search parameter
        # Should be present
        attribute :name, String # string

        # Source of definition
        attribute :source, Fhir::URI # uri

        # Type of search parameter
        # Should be present
        attribute :type, Fhir::Code # code

        # Contents and meaning of search parameter
        # Should be present
        attribute :documentation, String # string

        # XPath that extracts the parameter set
        attribute :xpath, String # string

        # Types of resource (if a resource reference)
        attribute :target, Array[Fhir::Code] # code

        # Chained names supported
        attribute :chain, Array[String] # string
      end

      attribute :search_param, Array[SearchParam] # 
    end

    # Should be present
    attribute :resource, Array[Resource] # 

    # If batches are supported
    attribute :batch, Boolean # boolean

    # If a system wide history list is supported
    attribute :history, Boolean # boolean

    # Definition of a named query and its parameters and their
    # meaning.
    class Query < Fhir::ValueObject
      # Name of the query (_query=)
      # Should be present
      attribute :name, String # string

      # Describes the named query
      # Should be present
      attribute :documentation, String # string

      # Parameter for the named query
      attribute :parameter, Array[Fhir::Conformance::Rest::Resource::SearchParam] # @Conformance.rest.resource.searchParam
    end

    attribute :query, Array[Query] # 
  end

  attribute :rest, Array[Rest] # 

  # Describes the messaging capabilities of the solution.
  class Messaging < Fhir::ValueObject
    # Actual endpoint being described
    attribute :endpoint, Fhir::URI # uri

    # Reliable Message Cache Length
    attribute :reliable_cache, Integer # integer

    # Messaging interface behavior details
    attribute :documentation, String # string

    # Describes the solution's support for an event at this end
    # point.
    class Event < Fhir::ValueObject
      # Event type
      # Should be present
      attribute :code, Fhir::Code # code

      # sender | receiver
      # Should be present
      attribute :mode, Fhir::Code # code

      # http | ftp |MLLP | etc.
      attribute :protocol, Array[Fhir::Coding] # Coding

      # Resource that's focus of message
      # Should be present
      attribute :focus, Fhir::Code # code

      # Profile that describes the request
      # Should be present
      attribute :request, Fhir::ResourceReference[Fhir::Profile] # Resource(Profile)

      # Profile that describes the response
      # Should be present
      attribute :response, Fhir::ResourceReference[Fhir::Profile] # Resource(Profile)

      # Endpoint-specific event documentation
      attribute :documentation, String # string
    end

    # Should be present
    attribute :event, Array[Event] # 
  end

  attribute :messaging, Array[Messaging] # 

  # A document definition.
  class Document < Fhir::ValueObject
    # producer | consumer
    # Should be present
    attribute :mode, Fhir::Code # code

    # Description of document support
    attribute :documentation, String # string

    # Constraint on a resource used in the document
    # Should be present
    attribute :profile, Fhir::ResourceReference[Fhir::Profile] # Resource(Profile)
  end

  attribute :document, Array[Document] # 
end

