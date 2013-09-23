# A set of information summarized from a list of other
# resources.
class Fhir::List < Fhir::Resource
  invariants do
    validates_presence_of :mode
  end

  # Text summary of the resource, for human interpretation
  attribute :text, Fhir::Narrative

  # What the purpose of this list is
  attribute :code, Fhir::CodeableConcept

  # Source of the list
  resource_reference :source, [Fhir::Practitioner, Fhir::Patient, Fhir::Device]

  # When the list was prepared
  attribute :date, DateTime

  # Whether items in the list have a meaningful order
  attribute :ordered, Boolean

  # working | snapshot | changes
  attribute :mode, Fhir::Code

  # Entries in this list.
  class Entry < Fhir::ValueObject
    invariants do
      validates_presence_of :item_ref
    end

    # Workflow information about this item
    attribute :flags, Array[Fhir::CodeableConcept]

    # If this item is actually marked as deleted
    attribute :deleted, Boolean

    # When item added to list
    attribute :date, DateTime

    # Actual entry
    resource_reference :item, [Fhir::Resource]
  end

  attribute :entries, Array[Entry]

  # Why list is empty
  attribute :empty_reason, Fhir::CodeableConcept
end


Fhir.load_handmade('list')
