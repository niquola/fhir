class Fhir::ResourceReference < Fhir::DataType
  attribute :type, String
  attribute :reference, String
  attribute :display, String

  def initialize(attributes = {})
    @instance = attributes.delete(:instance)
    @container = attributes.delete(:container)

    super(attributes)
  end
end
