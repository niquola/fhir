# An person that is related to a patient, but who is not a direct target of care
class RelatedPerson
  include Virtus
  # Additional Content defined by implementations
  attribute :extension, Extension

  # Text summary of the resource, for human interpretation
  attribute :text, Narrative

  # Contained, inline Resources
  attribute :contained, Resource

  # A Human identifier for this person
  attribute :identifier, Identifier

  # The patient this person is related to
  attribute :patient, Resource(Patient)

  # The nature of the relationship
  attribute :relationship, CodeableConcept

  # A name associated with the person
  attribute :name, HumanName

  # A contact detail for the person
  attribute :telecom, Contact

  # Gender for administrative purposes
  attribute :gender, CodeableConcept

  # Address where the related person can be contacted or visited
  attribute :address, Address

  # Image of the person
  attribute :photo, Attachment

end
