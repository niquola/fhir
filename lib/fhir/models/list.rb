# Information summarized from a list of other resources
class List
  include Virtus
  # Additional Content defined by implementations
  attribute :extension, Extension

  # Text summary of the resource, for human interpretation
  attribute :text, Narrative

  # Contained, inline Resources
  attribute :contained, Resource

  # What the purpose of this list is
  attribute :code, CodeableConcept

  # Source of the list
  attribute :source, Resource(Practitioner|Patient|Device)

  # When the list was prepared
  attribute :date, DateTime

  # Whether items in the list have a meaningful order
  attribute :ordered, boolean

  # working | snapshot | changes
  attribute :mode, code

  # Entries in the list
  attribute :entry, Entry

  class Entry
    include Virtus::ValueObject
    # Workflow information about this item
    attribute :flag, CodeableConcept

    # If this item is actually marked as deleted
    attribute :deleted, boolean

    # When item added to list
    attribute :date, DateTime

    # Actual entry
    attribute :item, Resource(Any)

  end
  # Why list is empty
  attribute :emptyReason, CodeableConcept

end
