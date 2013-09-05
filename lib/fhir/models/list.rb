# A set of information summarized from a list of other
# resources.
class Fhir::List < Fhir::Resource
  invariants do
    validates_presence_of :mode
  end

  # What the purpose of this list is
  attribute :code, Fhir::CodeableConcept

  # Source of the list
  resource_reference :source, [Fhir::Practitioner, Fhir::Patient, Fhir::Device]

  # When the list was prepared
  attribute :date, DateTime

  # Whether items in the list have a meaningful order
  attribute :ordered, Boolean

  # working | snapshot | changes
  # Should be present
  attribute :mode, Fhir::Code

  # Entries in this list.
  class Entry < Fhir::ValueObject
    invariants do
      validates_presence_of :item
    end

    # Workflow information about this item
    attribute :flags, Array[Fhir::CodeableConcept]

    # If this item is actually marked as deleted
    attribute :deleted, Boolean

    # When item added to list
    attribute :date, DateTime

    # Actual entry
    # Should be present
    resource_reference :item, [Fhir::Resource]
  end

  attribute :entries, Array[Entry]

  # Why list is empty
  attribute :empty_reason, Fhir::CodeableConcept
end

