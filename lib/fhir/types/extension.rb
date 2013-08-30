class Fhir::Extension < Fhir::Type
  attribute :urls, Array[Fhir::uri]
  attribute :is_modifiers, Array[Boolean]
  attribute :value[x]s, Array[Fhir::*]
end
