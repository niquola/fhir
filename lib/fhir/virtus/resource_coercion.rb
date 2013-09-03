module Fhir::Virtus::ResourceCoercion
  private

  def coerce_member(value)
    if value.is_a?(::Hash)
      type = value.delete(:resource_type)
      puts "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!" + value.to_yaml if type.nil?
      klass = type.constantize

      check_type!(klass)
      klass.new(value)
    else
      check_type!(value.class)
      value
    end
  end

  def allowed_types
    @options[:types]
  end

  def check_type!(klass)
    unless allowed_types.any? { |t| klass <= t }
      raise ArgumentError.new("Unexpected type #{klass.name}, expected one of: #{allowed_types.inspect}")
    end
  end
end
