# A set of information summarized from a list of other
# resources.
class Fhir::List < Fhir::Resource
  # Additional Content defined by implementations
  attribute :extension, Array[Fhir::Extension] # Extension

  # Text summary of the resource, for human interpretation
  attribute :text, Fhir::Narrative # Narrative

  # Contained, inline Resources
  attribute :contained, Array[Fhir::Resource] # Resource

  # What the purpose of this list is
  attribute :code, Fhir::CodeableConcept # CodeableConcept

  # Source of the list
  attribute :source, Fhir::ResourceReference[Fhir::Practitioner, Fhir::Patient, Fhir::Device] # Resource(Practitioner|Patient|Device)

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
    attribute :flag, Array[Fhir::CodeableConcept] # CodeableConcept

    # If this item is actually marked as deleted
    attribute :deleted, Boolean # boolean

    # When item added to list
    attribute :date, DateTime # dateTime

    # Actual entry
    # Should be present
    attribute :item, Fhir::ResourceReference # Resource(Any)
  end

  attribute :entry, Array[Entry] # 

  # Why list is empty
  attribute :empty_reason, Fhir::CodeableConcept # CodeableConcept
end

