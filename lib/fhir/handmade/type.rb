class Fhir::Type
  include Virtus::ValueObject
  extend Fhir::ResourceRefering
  include Fhir::Virtus::Serializable

  include Fhir::Virtus::ResourceCoercion

  class TypeAttribute < Virtus::Attribute::Object
    primitive       ::Object
    accept_options :types
    coercion_method :to_object

    include Fhir::Virtus::ResourceCoercion
    def set(instance, value)
      super(instance, coerce_member(value))
    end
  end

  def self.[](*types)
    [TypeAttribute, {types: types}]
  end
end
