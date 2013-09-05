# All kinds of technology mediated contact details for a
# person or organisation, including telephone, email, etc.
class Fhir::Contact < Fhir::DataType
  # Telecommunications form for contact
  attribute :system, Fhir::Code

  # The actual contact details
  attribute :value, String

  # How to use this address
  attribute :use, Fhir::Code

  # Time period when the contact was/is in use
  attribute :period, Fhir::Period
end

