# A set of information summarized from a list of other
# resources.
class Fhir::List < Fhir::Resource
  # Additional Content defined by implementations
  attribute :extension, Array[Extension]

  # Text summary of the resource, for human interpretation
  attribute :text, Narrative

  # Contained, inline Resources
  attribute :contained, Array[ResourceLink[Resource]]

  # What the purpose of this list is
  attribute :code, CodeableConcept

  # Source of the list
  attribute :source, ResourceLink[Practitioner, Patient, Device]

  # When the list was prepared
  attribute :date, dateTime

  # Whether items in the list have a meaningful order
  attribute :ordered, boolean

  # working | snapshot | changes
  # Should be present
  attribute :mode, code

  # Entries in this list.
  class Entry < Fhir::ValueObject
    # Workflow information about this item
    attribute :flag, Array[CodeableConcept]

    # If this item is actually marked as deleted
    attribute :deleted, boolean

    # When item added to list
    attribute :date, dateTime

    # Actual entry
    # Should be present
    attribute :item, ResourceLink[Any]
  end

  attribute :entry, Array[Entry]

  # Why list is empty
  attribute :empty_reason, CodeableConcept
end

