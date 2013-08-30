# All kinds of technology mediated contact details for a
# person or organisation, including telephone, email, etc.
class Fhir::Contact < Fhir::Type
  # Telecommunications form for contact
  attribute :system, Fhir::Code # code

  # The actual contact details
  attribute :value, String # string

  # How to use this address
  attribute :use, Fhir::Code # code

  # Time period when the contact was/is in use
  attribute :period, Fhir::Period # Period
end

