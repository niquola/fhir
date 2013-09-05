class Fhir::Type
  include Virtus
  include Fhir::Virtus
  include Fhir::Validations

  def initialize(attributes, options = {})
    @options = options || {}
    super(attributes)
  end

  # For Virtus attributes DSL syntax
  def self.[](*types)
    [Object, { coercer: Fhir::Virtus::Coercer.new(*types) }]
  end

  def self.resource_reference(attribute_name, resource_types)
    attribute attribute_name, *Fhir::Type[*resource_types]
    attribute "#{attribute_name}_ref", Fhir::ResourceReference

    define_method "#{attribute_name}=" do |value|
      super(value)

      assigned_resource = send(attribute_name)
      send("#{attribute_name}_ref=", assigned_resource.to_ref(self)) if assigned_resource
    end
  end

  def self.resource_references(attribute_name, resource_types)
    ref_attr_name = "#{attribute_name.to_s.singularize}_refs"
    attribute attribute_name, *Fhir::Collection[*resource_types]
    attribute ref_attr_name, Array[Fhir::ResourceReference]

    define_method "#{attribute_name}=" do |values|
      super(values)

      assigned_resources = send(attribute_name)
      send("#{ref_attr_name}=", assigned_resources.map { |s| !s.nil? && s.to_ref(self) }.compact)
    end
  end
end
