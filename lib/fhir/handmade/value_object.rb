class Fhir::ValueObject
  include Virtus::ValueObject
  extend Fhir::ResourceRefering
  include Fhir::Virtus
  include Fhir::Validations

  def initialize(attributes, options = {})
    @options = options || {}
    super(attributes)
  end

end
