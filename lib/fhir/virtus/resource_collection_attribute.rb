class Fhir::Virtus::ResourceCollectionAttribute < Virtus::Attribute::Array
  include Fhir::Virtus::ResourceCoercion
  primitive       ::Array
  coercion_method :to_array
  default         primitive.new

  def set(instance, value)
    vals = Array(value).map do |v|
      coerce_member(v)
    end
    super(instance, vals)

    instance.send("#{name.to_s.singularize}_refs=",  vals.map(&:to_ref))
  end
end
