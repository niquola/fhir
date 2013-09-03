class Fhir::ResourceReference < Fhir::Type
  attribute :type, String
  attribute :reference, String

  def initialize(attributes = {})
    @instance = attributes.delete(:instance)
    @container = attributes.delete(:container)

    super(attributes)
  end
end
