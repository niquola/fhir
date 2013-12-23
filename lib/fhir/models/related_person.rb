# Information about a person that is involved in the care
# for a patient, but who is not the target of healthcare, nor
# has a formal responsibility in the care process.
class Fhir::RelatedPerson < Fhir::Resource
  invariants do
    validates_presence_of :patient_ref
  end

  # Extensions that cannot be ignored
  attribute :modifier_extension, Array[Fhir::Extension]

  # Text summary of the resource, for human interpretation
  attribute :text, Fhir::Narrative

  # A Human identifier for this person
  attribute :identifier, Array[Fhir::Identifier]

  # The patient this person is related to
  resource_reference :patient, [Fhir::Patient]

  # The nature of the relationship
  attribute :relationship, Fhir::CodeableConcept

  # A name associated with the person
  attribute :name, Fhir::HumanName

  # A contact detail for the person
  attribute :telecom, Array[Fhir::Contact]

  # Gender for administrative purposes
  attribute :gender, Fhir::CodeableConcept

  # Address where the related person can be contacted or
  # visited
  attribute :address, Fhir::Address

  # Image of the person
  attribute :photo, Array[Fhir::Attachment]
end


Fhir.load_extension('related_person')
