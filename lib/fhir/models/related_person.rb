# Information about a person that is involved in the care
# for a patient, but who is not the target of healthcare, nor
# has a formal responsibility in the care process.
class Fhir::RelatedPerson < Fhir::Resource
  # Additional Content defined by implementations
  attribute :extension, Array[Extension]

  # Text summary of the resource, for human interpretation
  attribute :text, Narrative

  # Contained, inline Resources
  attribute :contained, Array[ResourceLink[Resource]]

  # A Human identifier for this person
  attribute :identifier, Array[Identifier]

  # The patient this person is related to
  # Should be present
  attribute :patient, ResourceLink[Patient]

  # The nature of the relationship
  attribute :relationship, CodeableConcept

  # A name associated with the person
  attribute :name, HumanName

  # A contact detail for the person
  attribute :telecom, Array[Contact]

  # Gender for administrative purposes
  attribute :gender, CodeableConcept

  # Address where the related person can be contacted or
  # visited
  attribute :address, Address

  # Image of the person
  attribute :photo, Array[Attachment]
end

