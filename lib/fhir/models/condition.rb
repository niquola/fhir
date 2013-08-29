class Condition
  attribute :extension, Extension
  attribute :text, Narrative
  attribute :contained, Resource
  attribute :subject, Resource(Patient)
  attribute :encounter, Resource(Encounter)
  attribute :asserter, Resource(Practitioner|Patient)
  attribute :dateAsserted, date
  attribute :code, CodeableConcept
  attribute :category, CodeableConcept
  attribute :status, code
  attribute :certainty, CodeableConcept
  attribute :severity, CodeableConcept
  attribute :onset[x], date
  attribute :abatement[x], date
  attribute :stage, Stage
  class Stage
    attribute :summary, CodeableConcept
    attribute :assessment, Resource(Any)
  end
  attribute :evidence, Evidence
  class Evidence
    attribute :code, CodeableConcept
    attribute :detail, Resource(Any)
  end
  attribute :location, Location
  class Location
    attribute :code, CodeableConcept
    attribute :detail, String
  end
  attribute :relatedItem, RelatedItem
  class RelatedItem
    attribute :type, code
    attribute :code, CodeableConcept
    attribute :target, Resource(Condition|Procedure|Substance)
  end
  attribute :notes, String
end
