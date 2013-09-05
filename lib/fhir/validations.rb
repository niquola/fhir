require 'active_model'

module Fhir
  module Validations
    extend ActiveSupport::Concern

    included do
      include ActiveModel::Validations

      private :valid?
      alias_method :my_errors, :errors
      private :my_errors
    end

    module ClassMethods
      def validate_attributes(attributes)
        self.new(attributes, skip_invariants_check: true)
      end

      def validator(validator_name, &block)
        with_options(:if => ->(obj) { obj.active_validators.include?(validator_name) }, &block)
      end

      def invariants(&block)
        validator(:invariants, &block)
      end
    end

    def errors
      # self.my_errors + collect_nested_errors
      my_errors
    end

    def validator_active?(validator_name)
      [:invariant].include?(validator_name)
    end

    def skip_invariants_check?
      !!(@options && @options[:skip_invariants_check])
    end

    private

    def validate_attribute(attr_name)
      valid?

      if !skip_invariants_check? && self.errors.present?
        raise "Invalid value for attribute #{attr_name}: " + self.errors.inspect
      end
    end

    def attribute_changed(attr_name)
      validate_attribute(attr_name)
    end
  end
end
