module Fhir
  module Virtus
    autoload :Serializable, 'fhir/virtus/serializable'
    autoload :Coercer, 'fhir/virtus/coercer'
    autoload :ArrayCoercer, 'fhir/virtus/array_coercer'

    extend ActiveSupport::Concern

    included do
      include Fhir::Virtus::Serializable
    end

    module ClassMethods
      def attribute(attribute_name, *args)
        super(attribute_name, *args)

        define_method "#{attribute_name}=" do |value|
          super(value)
          coerced_value = send(attribute_name)

          attribute_changed(attribute_name)
          coerced_value
        end
      end
    end

    private

    def attribute_changed(attribute_name)
    end
  end
end
