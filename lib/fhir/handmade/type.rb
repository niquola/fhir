require 'active_model'

class Fhir::Type
  include Virtus.model
  include Fhir::Virtus
  include ActiveModel::Validations

  module Validations
    def validate_attributes(attributes)
      self.new(attributes, true).to_hash_with_errors
    end

    def validator(validator_name, &block)
      with_options(:if => ->(obj) { obj.active_validators.include?(validator_name) }, &block)
    end

    def invariants(&block)
      validator(:invariants, &block)
    end
  end

  extend Validations

  attr_accessor :skip_invariants_check

  attr_accessor :parent

  def initialize(attributes_or_object, skip_invariants_check = false)
    @skip_invariants_check = skip_invariants_check

    attributes = if attributes_or_object.is_a?(::Hash)
                   attributes_or_object
                 else
                   attributes_or_object.serialize
                 end

    attrs_with_parent = attributes.symbolize_keys.clone

    self.class.check_attributes_keys!(attrs_with_parent)

    attrs_with_parent.each do |k,v|
      if v.is_a?(::Hash)
        v[:parent] = self
      elsif v.is_a?(::Array)
        v.each do |vv|
          vv[:parent] = self if vv.is_a?(::Hash)
        end
      end
    end

    @parent = attrs_with_parent.delete(:parent)
    @initiated = false
    super(attrs_with_parent)
    @initiated = true
    validate_attribute(:base)
  end

  def ==(other)
    self.class == other.class && self.serialize == other.serialize
  end

  def self.check_attributes_keys!(attrs)
    unknown_keys =  (attrs.keys - self.attribute_set.map(&:name) - [:parent, :_type])
    unless unknown_keys.empty?
      error_msg = "While creating #{self.name} unknown keys: #{unknown_keys.join(', ')}\n"
      error_msg += "Full hash: #{attrs.except(:parent, :_type).inspect}"

      raise ArgumentError, error_msg
    end
  end

  def skip_invariants_check?
    if parent.present?
      parent.skip_invariants_check?
    else
      @skip_invariants_check
    end
  end

  def self.create(attributes)
    instance = new(attributes)
    instance.check_invariants!
    instance.skip_invariants_check = false

    instance
  end

  def validator_active?(validator_name)
    [:invariant].include?(validator_name)
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

  def validate_attribute(attr_name)
    return unless @initiated

    valid?
    if !skip_invariants_check? && self.errors.present?
      raise "Invalid value for attribute #{attr_name}: " + self.errors.full_messages.join(", ")
    end
  end

  def attribute_changed(attr_name)
    attr = self[attr_name]
    if attr.is_a?(Fhir::Type)
      attr.parent = self
    end
    validate_attribute(attr_name)
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
      send("#{ref_attr_name}=", assigned_resources.map { |s| s.nil? ? nil : s.to_ref(self) }.compact)
    end
  end

  def inspect
    "<#{self.class.name} #{to_hash.except(:parent)}>"
  end
end
