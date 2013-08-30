class Fhir::Attachment < Fhir::Type
  attribute :content_types, Array[Fhir::Code]
  attribute :languages, Array[Fhir::Code]
  attribute :data, Array[Fhir::base64Binary]
  attribute :urls, Array[Fhir::uri]
  attribute :sizes, Array[Fhir::integer]
  attribute :hashes, Array[Fhir::base64Binary]
  attribute :titles, Array[Fhir::String]
end
