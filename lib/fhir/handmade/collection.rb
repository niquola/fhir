class Fhir::Collection
  def self.[](*types)
    [Array, { coercer: Fhir::Virtus::ArrayCoercer.new(*types) }]
  end
end
