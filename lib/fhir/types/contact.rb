# All kinds of technology mediated contact details for a
# person or organisation, including telephone, email, etc.
class Fhir::Contact < Fhir::DataType
  # phone | fax | email | url
  attribute :system, Fhir::Code

  # The actual contact details
  attribute :value, String

  # home | work | temp | old | mobile - purpose of this
  # address
  attribute :use, Fhir::Code

  # Time period when the contact was/is in use
  attribute :period, Fhir::Period
end

Fhir.load_extension('contact')
