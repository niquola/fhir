# A reference to a code defined by a terminology system.
class Fhir::Coding < Fhir::Type
  # Identity of the terminology system
  attribute :system, Fhir::URI # uri

  # Symbol in syntax defined by the system
  attribute :code, Fhir::Code # code

  # Representation defined by the system
  attribute :display, String # string
end

