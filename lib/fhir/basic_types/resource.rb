class Fhir::Resource
  include Virtus

  attribute :uuid, String

  def generate_uuid
    "##{rand(10000)}"
  end

  def initialize(attrs)
    attrs[:uuid] ||= generate_uuid
    super(attrs)
  end

  def self.resource_reference(name, types)
    attribute name, Fhir::Virtus::ResourceAttribute,
      types: Array(types)

    attribute "#{name}_ref", Fhir::ResourceReference
  end

  def self.resource_references(name, types)
    attribute name, Fhir::Virtus::ResourceCollectionAttribute,
      types: Array(types)

    attribute "#{name.to_s.singularize}_refs", Array[Fhir::ResourceReference]
  end

  def to_ref
    Fhir::ResourceReference.new(type: self.class.name,
				reference: "#{self.uuid}")
  end
end
