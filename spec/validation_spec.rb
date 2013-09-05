require 'spec_helper'
describe "Validation" do

  module Invariantus
    def initialize(attrs)
      super(attrs)
    end

    def self.included(base)
      base.extend(ClassMethods)
      super
    end

    module ClassMethods
      def coerce_attributes(attrs)
	res = {}
	attrs.each do |attr_name, v|
	  next if [:_type].include?(attr_name)

	  attr = attribute_set[attr_name.to_sym]
	  if attr.value_coerced?(v)
	    res[attr_name] = v
	    next
	  end

	  type = attr.type_to_coerce(v) if attr.respond_to?(:type_to_coerce)

	  unless type.present?
	    res[attr_name] = attr.coerce(v)
	    next
	  end

	  res[attr_name] = type.check_invariants(v)
	end
	res
      end

      def attrs_has_errors?(attrs)
	return false  unless attrs.is_a?(Hash)
	attrs.key?(:_errors) || attrs.values.any? {|v| attrs_has_errors?(v)}
      end

      def check_invariants(attrs)
	coerced_attrs = coerce_attributes(attrs)
	unless attrs_has_errors?(coerced_attrs)
	  errors = self._check_invariants(coerced_attrs)
	  coerced_attrs[:_errors] = errors if errors.present?
	end
	coerced_attrs
      end

      def _check_invariants(attrs)
	[]
      end
    end
  end

  class Coding < Fhir::Type
    include Invariantus

    attribute :code, String
    attribute :system, String

    def self._check_invariants(coerced_attrs)
      errors = []
      if coerced_attrs[:code].blank?
	errors<< [:code, :required]
      end
      errors
    end

  end

  class Substance < Fhir::Type
    include Invariantus
    attribute :codings, *Fhir::Collection[Coding]

    def self._check_invariants(attrs)
      raise 'ups'
    end
  end

  class Allergy < Fhir::Resource
    include Invariantus

    attribute :substance, *Fhir::Type[Substance]
  end

  example do
    attrs = Allergy.check_invariants(
      substance: {
	_type: 'Substance',
	codings: { _type: 'Coding' }
      }
    )

    p attrs
    attrs[:substance][:codings].first[:_errors].should == [
      [:code, :required]
    ]
  end
end
