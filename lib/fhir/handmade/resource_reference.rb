class Fhir::ResourceReference < Fhir::DataType
  attribute :type, String
  attribute :reference, Fhir::URI
  attribute :display, String

  def initialize(attributes = {})
    @instance = attributes.delete(:instance)
    @container = attributes.delete(:container)

    super(attributes)
  end

  def to_s
    self.reference
  end
end
