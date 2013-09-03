class Fhir::Virtus::ResourceAttribute < Virtus::Attribute
  include Fhir::Virtus::ResourceCoercion
  primitive       ::Object
  coercion_method :to_object

  def set(instance, value)
    v = coerce_member(value)
    super(instance, v)

    instance.send("#{name}_ref=",  v.to_ref(instance))
  end

  def get(instance)
    super(instance)
  end
end
