# A reference to a code defined by a terminology system.
class Fhir::Coding < Fhir::DataType
  # Identity of the terminology system
  attribute :system, Fhir::URI

  # Symbol in syntax defined by the system
  attribute :code, Fhir::Code

  # Representation defined by the system
  attribute :display, String

  def initialize(raw_attrs)
    attrs = raw_attrs.dup
    attrs[:system] ||= "urn:oid:#{attrs.delete(:system_oid)}"
    super(attrs)
  end

  def system_oid
    self.system.sub(/^urn\:oid\:/, '')
  end

  def to_concept
    Fhir::CodeableConcept.new(
      text: self.display,
      codings: [self]
    )
  end
end
