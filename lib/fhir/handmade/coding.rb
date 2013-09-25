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

    if attrs[:system].respond_to?(:uri)
      attrs[:system] = attrs[:system].uri
    end

    super(attrs)
  end

  def system_oid
    self.system.sub(/^urn\:oid\:/, '')
  end

  def get_system
    Fhir::CodeSystem.find_by_uri(self.system)
  end

  def to_concept
    Fhir::CodeableConcept.new(
      text: self.display,
      codings: [self]
    )
  end
end
