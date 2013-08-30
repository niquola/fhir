# Information about a person that is involved in the care
# for a patient, but who is not the target of healthcare, nor
# has a formal responsibility in the care process.
class Fhir::RelatedPerson < Fhir::Resource
  # Additional Content defined by implementations
  attribute :extension, Array[Fhir::Extension] # Extension

  # Text summary of the resource, for human interpretation
  attribute :text, Fhir::Narrative # Narrative

  # Contained, inline Resources
  attribute :contained, Array[Fhir::Resource] # Resource

  # A Human identifier for this person
  attribute :identifier, Array[Fhir::Identifier] # Identifier

  # The patient this person is related to
  # Should be present
  attribute :patient, Fhir::ResourceReference[Fhir::Patient] # Resource(Patient)

  # The nature of the relationship
  attribute :relationship, Fhir::CodeableConcept # CodeableConcept

  # A name associated with the person
  attribute :name, Fhir::HumanName # HumanName

  # A contact detail for the person
  attribute :telecom, Array[Fhir::Contact] # Contact

  # Gender for administrative purposes
  attribute :gender, Fhir::CodeableConcept # CodeableConcept

  # Address where the related person can be contacted or
  # visited
  attribute :address, Fhir::Address # Address

  # Image of the person
  attribute :photo, Array[Fhir::Attachment] # Attachment
end

