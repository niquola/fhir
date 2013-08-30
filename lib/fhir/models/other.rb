# Other is a conformant for handling resource concepts not
# yet defined for FHIR or outside HL7's scope of interest.
class Fhir::Other < Fhir::Resource
  # Additional Content defined by implementations
  attribute :extension, Array[Fhir::Extension] # Extension

  # Text summary of the resource, for human interpretation
  attribute :text, Fhir::Narrative # Narrative

  # Contained, inline Resources
  attribute :contained, Array[Fhir::Resource] # Resource

  # Kind of Resource
  # Should be present
  attribute :code, Fhir::CodeableConcept # CodeableConcept

  # Identifies the
  attribute :subject, Fhir::ResourceReference # Resource(Any)

  # Who created
  attribute :author, Fhir::ResourceReference[Fhir::Practitioner, Fhir::Patient, Fhir::RelatedPerson] # Resource(Practitioner|Patient|RelatedPerson)

  # When created
  attribute :created, Date # date
end

