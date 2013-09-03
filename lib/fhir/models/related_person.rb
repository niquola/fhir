# Information about a person that is involved in the care
# for a patient, but who is not the target of healthcare, nor
# has a formal responsibility in the care process.
class Fhir::RelatedPerson < Fhir::Resource
  # A Human identifier for this person
  attribute :identifiers, Array[Fhir::Identifier] # Identifier

  # The patient this person is related to
  # Should be present
  resource_reference :patient, [Fhir::Patient]

  # The nature of the relationship
  attribute :relationship, Fhir::CodeableConcept # CodeableConcept

  # A name associated with the person
  attribute :name, Fhir::HumanName # HumanName

  # A contact detail for the person
  attribute :telecoms, Array[Fhir::Contact] # Contact

  # Gender for administrative purposes
  attribute :gender, Fhir::CodeableConcept # CodeableConcept

  # Address where the related person can be contacted or
  # visited
  attribute :address, Fhir::Address # Address

  # Image of the person
  attribute :photos, Array[Fhir::Attachment] # Attachment
end

