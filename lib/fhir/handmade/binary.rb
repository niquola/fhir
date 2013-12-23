class Fhir::Binary < Fhir::Resource
  attribute :content_type, Fhir::Code
  attribute :content,      String
end
