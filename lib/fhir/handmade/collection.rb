class Fhir::Collection
  def self.[](*types)
    [Virtus::Attribute::Array, { coercer: Fhir::Virtus::ArrayCoercer.new(*types) }]
  end
end
