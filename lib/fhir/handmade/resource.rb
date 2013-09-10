require 'securerandom'

class Fhir::Resource < Fhir::Type
  # Unique Identifier for Resource
  # see http://www.hl7.org/implement/standards/fhir/resources.htm#metadata
  attribute :uuid, String
  attribute :last_modified_date, Time

  # Unique Resource Identifier
  def uri
    Fhir::URI.new("#{self.class.name.tableize}/#{self.uuid}")
  end

  # Additional Content defined by implementations
  attribute :extensions, Array[Fhir::Extension] # Extension

  # Text summary of the resource, for human interpretation
  attribute :text, Fhir::Narrative # Narrative

  # Contained, inline Resources
  attribute :containeds, Array[Fhir::Resource] # Resource

  def self.generate_uuid
    SecureRandom.uuid
  end

  def initialize(attributes, skip_invariants_check = false)
    attributes[:uuid] ||= self.class.generate_uuid
    super(attributes, skip_invariants_check)
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
                                reference: self.uri,
                                container: container,
                                instance: self)
  end
end
