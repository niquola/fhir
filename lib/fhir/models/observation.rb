class Observation
  attribute :extension, Extension
  attribute :text, Narrative
  attribute :contained, Resource
  attribute :name, CodeableConcept
  attribute :value[x], Quantity
  attribute :interpretation, CodeableConcept
  attribute :comments, String
  attribute :applies[x], Period
  attribute :issued, instant
  attribute :status, code
  attribute :reliability, code
  attribute :bodySite, CodeableConcept
  attribute :method, CodeableConcept
  attribute :identifier, Identifier
  attribute :subject, Resource(Patient|Group|Device)
  attribute :performer, Resource(Practitioner|Device|Organization)
  attribute :referenceRange, ReferenceRange
  class ReferenceRange
    attribute :meaning, CodeableConcept
    attribute :range[x], Quantity
  end
  attribute :component, Component
  class Component
    attribute :name, CodeableConcept
    attribute :value[x], Quantity
  end
end
