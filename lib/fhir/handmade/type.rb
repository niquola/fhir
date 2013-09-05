class Fhir::Type
  include Virtus::ValueObject
  extend Fhir::ResourceRefering

  include Fhir::Virtus
  include Fhir::Validations

  include Fhir::Virtus::ResourceCoercion

  def initialize(attributes, options = {})
    @options = options || {}
    super(attributes)
  end

  # For Virtus attributes DSL syntax
  def self.[](*types)
    [Object, { coercer: Fhir::Virtus::Coercer.new(*types) }]
  end
end
