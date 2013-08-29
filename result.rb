class Conformance
  attribute :Conformance, Resource
  class ConformanceExtension
    attribute :extension, Extension
    attribute :text, Narrative
    attribute :contained, Resource
    attribute :identifier, string
    attribute :version, string
    attribute :name, string
    attribute :publisher, string
    attribute :telecom, Contact
    attribute :description, string
    attribute :status, code
    attribute :experimental, boolean
    attribute :date, dateTime
    attribute :software, 
    class ConformanceSoftwareName
      attribute :name, string
      attribute :version, string
      attribute :releaseDate, dateTime
    end
    class ConformanceImplementationDescription
      attribute :description, string
      attribute :url, uri
    end
    attribute :acceptUnknown, boolean
    attribute :format, code
    attribute :rest, 
    class ConformanceRestMode
      attribute :mode, code
      attribute :documentation, string
      attribute :security, 
      class ConformanceRestSecurityService
        attribute :service, CodeableConcept
        attribute :description, string
        attribute :certificate, 
        class ConformanceRestSecurityCertificateType
          attribute :type, code
          attribute :blob, base64Binary
        end
      end
      class ConformanceRestResourceType
        attribute :type, code
        attribute :profile, Resource(Profile)
        attribute :operation, 
        class ConformanceRestResourceOperationCode
          attribute :code, code
          attribute :documentation, string
        end
        attribute :searchInclude, string
        attribute :searchParam, 
        class ConformanceRestResourceSearchParamName
          attribute :name, string
          attribute :source, uri
          attribute :type, code
          attribute :documentation, string
          attribute :xpath, string
          attribute :target, code
          attribute :chain, string
        end
      end
      attribute :history, boolean
      attribute :query, 
      class ConformanceRestQueryName
        attribute :name, string
        attribute :documentation, string
        attribute :parameter, @Conformance.rest.resource.searchParam
      end
    end
    class ConformanceMessagingEndpoint
      attribute :endpoint, uri
      attribute :reliableCache, integer
      attribute :documentation, string
      attribute :event, 
      class ConformanceMessagingEventCode
        attribute :code, code
        attribute :mode, code
        attribute :protocol, Coding
        attribute :focus, code
        attribute :request, Resource(Profile)
        attribute :response, Resource(Profile)
        attribute :documentation, string
      end
    end
    class ConformanceDocumentMode
      attribute :mode, code
      attribute :documentation, string
      attribute :profile, Resource(Profile)
    end
  end
end
