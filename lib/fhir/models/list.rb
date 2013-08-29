class List
  attribute :extension, Extension
  attribute :text, Narrative
  attribute :contained, Resource
  attribute :code, CodeableConcept
  attribute :source, Resource(Practitioner|Patient|Device)
  attribute :date, DateTime
  attribute :ordered, boolean
  attribute :mode, code
  attribute :entry, Entry
  class Entry
    attribute :flag, CodeableConcept
    attribute :deleted, boolean
    attribute :date, DateTime
    attribute :item, Resource(Any)
  end
  attribute :emptyReason, CodeableConcept
end
