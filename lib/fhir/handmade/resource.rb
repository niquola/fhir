require 'securerandom'

class Fhir::Resource < Fhir::Type
  # Unique Identifier for Resource
  attribute :uuid, String

  # Unique Resource Identifier
  def uri
    "#{self.class.name.tableize}/#{self.uuid}"
  end

  # Additional Content defined by implementations
  attribute :extensions, Array[Fhir::Extension] # Extension

  # Text summary of the resource, for human interpretation
  attribute :text, Fhir::Narrative # Narrative

  # Contained, inline Resources
  attribute :contained, Array[Fhir::Resource] # Resource

  def self.generate_uuid
    SecureRandom.uuid
  end

  def initialize(attributes, options = {})
    attributes[:uuid] ||= self.class.generate_uuid
    super(attributes)

    contained!
  end

  def independent?
    @independent
  end

  def independent!
    @independent = true
  end

  def contained?
    !@independent
  end

  def contained!
    @independent = false
  end

  def to_ref(container = nil)
    Fhir::ResourceReference.new(type: self.class.name,
                                reference: "#{self.uuid}",
                                container: container,
                                instance: self)
  end
end
