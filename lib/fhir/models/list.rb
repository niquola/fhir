# A set of information summarized from a list of other
# resources.
class Fhir::List < Fhir::Resource
  # What the purpose of this list is
  attribute :code, Fhir::CodeableConcept # CodeableConcept

  # Source of the list
  resource_reference :source, [Fhir::Practitioner, Fhir::Patient, Fhir::Device]

  # When the list was prepared
  attribute :date, DateTime # dateTime

  # Whether items in the list have a meaningful order
  attribute :ordered, Boolean # boolean

  # working | snapshot | changes
  # Should be present
  attribute :mode, Fhir::Code # code

  # Entries in this list.
  class Entry < Fhir::ValueObject
    # Workflow information about this item
    attribute :flags, Array[Fhir::CodeableConcept] # CodeableConcept

    # If this item is actually marked as deleted
    attribute :deleted, Boolean # boolean

    # When item added to list
    attribute :date, DateTime # dateTime

    # Actual entry
    # Should be present
    resource_reference :item, [Fhir::Resource]
  end

  attribute :entries, Array[Entry] # 

  # Why list is empty
  attribute :empty_reason, Fhir::CodeableConcept # CodeableConcept
end

