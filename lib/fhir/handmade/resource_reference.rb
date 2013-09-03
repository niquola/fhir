class Fhir::ResourceReference < Fhir::Type
  attribute :type, String
  attribute :reference, String

  class << self
    def [](*types)
      self
    end
  end
end
