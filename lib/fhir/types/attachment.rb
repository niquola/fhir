# For referring to data content defined in other formats.
class Fhir::Attachment < Fhir::DataType
  invariants do
    validates_presence_of :content_type
  end

  # Mime type of the content, with charset etc.
  attribute :content_type, Fhir::Code

  # Human language of the content (BCP-47)
  attribute :language, Fhir::Code

  # Data inline, base64ed
  attribute :data, String

  # Uri where the data can be found
  attribute :url, Fhir::URI

  # Number of bytes of content (if url provided)
  attribute :size, Integer

  # Hash of the data (sha-1, base64ed )
  attribute :hash, String

  # Label to display in place of the data
  attribute :title, String
end

Fhir.load_extension('attachment')
