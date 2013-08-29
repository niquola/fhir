class ImagingStudy
  attribute :extension, Extension
  attribute :text, Narrative
  attribute :contained, Resource
  attribute :dateTime, DateTime
  attribute :subject, Resource(Patient)
  attribute :uid, oid
  attribute :accessionNo, Identifier
  attribute :identifier, Identifier
  attribute :modality, code
  attribute :referrer, Resource(Practitioner)
  attribute :availability, code
  attribute :url, uri
  attribute :numberOfSeries, integer
  attribute :numberOfInstances, integer
  attribute :clinicalInformation, String
  attribute :procedure, Coding
  attribute :interpreter, Resource(Practitioner)
  attribute :description, String
  attribute :series, Series
  class Series
    attribute :number, integer
    attribute :modality, code
    attribute :uid, oid
    attribute :description, String
    attribute :numberOfInstances, integer
    attribute :availability, code
    attribute :url, uri
    attribute :bodySite, Coding
    attribute :dateTime, DateTime
    attribute :instance, Instance
    class Instance
      attribute :number, integer
      attribute :uid, oid
      attribute :sopclass, oid
      attribute :type, String
      attribute :title, String
      attribute :url, uri
      attribute :attachment, Resource(Any)
    end
  end
end
