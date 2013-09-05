module Fhir::Virtus
  class ArrayCoercer
    def initialize(*types)
      @types = types
      @member_coercer = Fhir::Virtus::Coercer.new(*types)
    end

    def call(value)
      value = [value] if !value.is_a?(Array)

      value.map { |el| @member_coercer.call(el) }
    end
  end
end
