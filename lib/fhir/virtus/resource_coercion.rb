module Fhir::Virtus::ResourceCoercion
  def coerce_member(value)
    if value.is_a?(::Hash)
      type = value.delete(:resource_type)
      check_type!(type)
      get_type(type).new(value)
    else
      check_type!(value.class.name)
      value
    end
  end

  def allowed_types
    @options[:types]
  end

  def get_type(type_name)
    allowed_types.find {|t| t.name == type_name.to_s }
  end

  def check_type!(type)
    unless allowed_types.find {|t| t.name == type}
      raise ArgumentError.new("Unexpected type #{type}, expected one of: #{allowed_types.inspect}")
    end
  end
end
