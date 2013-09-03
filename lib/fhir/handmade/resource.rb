class Fhir::Resource
  include Virtus
  extend Fhir::ResourceRefering

  # Unique Identifier for Resource
  attribute :uuid, String

  # Additional Content defined by implementations
  attribute :extensions, Array[Fhir::Extension] # Extension

  # Text summary of the resource, for human interpretation
  attribute :text, Fhir::Narrative # Narrative

  # Contained, inline Resources
  attribute :contained, Array[Fhir::Resource] # Resource

  def self.generate_uuid
    "##{rand(10000)}"
  end

  def initialize(attributes = {})
    raise "!BANG!" if self.class.nil?

    attributes[:uuid] ||= self.class.generate_uuid
    super(attributes)
  end

  def to_ref
    Fhir::ResourceReference.new(type: self.class.name,
				reference: "#{self.uuid}")
  end
end
