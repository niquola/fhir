class Fhir::Type
  include Virtus
  include Fhir::Virtus
  include Fhir::Validations

  attr_accessor :skip_invariants_check

  def initialize(attributes)
    @skip_invariants_check = true
    super(attributes)
  end

  def self.create(attributes)
    instance = new(attributes)
    instance.check_invariants!
    instance.skip_invariants_check = false

    instance
  end

  def check_invariants!
    found_errors = []

    collect_errors = lambda do |hash|
      found_errors << hash[:_errors] if hash[:_errors].present?

      hash.each do |key, value|
        next if key == :_errors
        if value.is_a?(Hash)
          collect_errors.call(value)
        elsif value.is_a?(Array)
          value.each { |el| collect_errors.call(el) if el.is_a?(Hash) }
        end
      end
    end

    collect_errors.call(self.to_hash_with_errors)

    raise "Invalid values: #{found_errors.inspect}" if found_errors.present?
  end

  def to_hash_with_errors
    valid?
    result = {}

    to_hash_with_errors = ->(v) {
      v.respond_to?(:to_hash_with_errors) ? v.to_hash_with_errors : v
    }

    self.to_hash.each do |attribute, value|
      value = send(attribute)

      if value.is_a?(Array)
        result[attribute] = value.map { |v| to_hash_with_errors.call(v) }
      else
        result[attribute] = to_hash_with_errors.call(value)
      end
    end

    result[:_errors] = self.errors if self.errors.present?
    result
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
