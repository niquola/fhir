# For referring to data content defined in other formats.
class Fhir::Attachment < Fhir::Type
  # Mime type of the content, with charset etc.
  # Should be present
  attribute :content_type, Fhir::Code # code

  # Human language of the content (BCP-47)
  attribute :language, Fhir::Code # code

  # Data inline, base64ed
  attribute :data, String # base64Binary

  # Uri where the data can be found
  attribute :url, Fhir::URI # uri

  # Number of bytes of content (if url provided)
  attribute :size, Integer # integer

  # Hash of the data (sha-1, base64ed )
  attribute :hash, String # base64Binary

  # Label to display in place of the data
  attribute :title, String # string
end

