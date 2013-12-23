# Other is a conformant for handling resource concepts not
# yet defined for FHIR or outside HL7's scope of interest.
class Fhir::Other < Fhir::Resource
  invariants do
    validates_presence_of :code
  end

  # Extensions that cannot be ignored
  attribute :modifier_extension, Array[Fhir::Extension]

  # Text summary of the resource, for human interpretation
  attribute :text, Fhir::Narrative

  # Kind of Resource
  attribute :code, Fhir::CodeableConcept

  # Identifies the
  resource_reference :subject, [Fhir::Resource]

  # Who created
  resource_reference :author, [Fhir::Practitioner, Fhir::Patient, Fhir::RelatedPerson]

  # When created
  attribute :created, Date
end


Fhir.load_extension('other')
