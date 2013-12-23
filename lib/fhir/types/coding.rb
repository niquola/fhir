# A reference to a code defined by a terminology system.
class Fhir::Coding < Fhir::DataType
  # Identity of the terminology system
  attribute :system, Fhir::URI

  # Version of the system - if relevant
  attribute :version, String

  # Symbol in syntax defined by the system
  attribute :code, Fhir::Code

  # Representation defined by the system
  attribute :display, String

  # If this code was chosen directly by the user
  attribute :primary, Boolean

  # Set this coding was chosen from
  resource_reference :value_set, [Fhir::ValueSet]
end

Fhir.load_extension('coding')
