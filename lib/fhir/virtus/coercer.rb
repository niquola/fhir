module Fhir::Virtus
  class Coercer
    def initialize(*types)
      @types = types
    end

    def call(value)
      value = value.symbolize_keys if value.is_a?(::Hash)

      if value.is_a?(::Hash) && value.key?(:_type)
        type = value[:_type]

        klass = type.constantize

        check_type!(klass, value)
        klass.new(value)
      else
        coerced_value = coerce_according_to_types(value)
        check_type!(coerced_value.class, value)
        coerced_value
      end
    end

    private

    def virtus_coerce(type, value)
      method = "to_#{type.name.downcase}"
      coercer = Virtus.coercer[value.class]

      if coercer.respond_to?(method)
        coercer.public_send(method, value)
      end
    end

    def coerce_according_to_types(value)
      return nil if value.nil?

      if allowed_types.include?(value.class)
        value
      else
        result = nil

        allowed_types.each do |type|
          result = virtus_coerce(type, value)

          if !result.nil? && result.class <= type
            break
          end
        end

        result
      end
    end

    def allowed_types
      @types
    end

    def check_type!(klass, value)
      if klass != NilClass && !allowed_types.any? { |t| klass <= t }
        raise ArgumentError.new("Unexpected value with type #{klass.name}, expected one of: #{allowed_types.inspect}\n#{value.to_yaml}")
      end
    end
  end
end
