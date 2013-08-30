# Other is a conformant for handling resource concepts not
# yet defined for FHIR or outside HL7's scope of interest.
class Fhir::Other < Fhir::Resource
  # Additional Content defined by implementations
  attribute :extension, Array[Extension]

  # Text summary of the resource, for human interpretation
  attribute :text, Narrative

  # Contained, inline Resources
  attribute :contained, Array[ResourceLink[Resource]]

  # Kind of Resource
  # Should be present
  attribute :code, CodeableConcept

  # Identifies the
  attribute :subject, ResourceLink[Any]

  # Who created
  attribute :author, ResourceLink[Practitioner, Patient, RelatedPerson]

  # When created
  attribute :created, date
end

