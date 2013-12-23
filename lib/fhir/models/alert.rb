# Prospective warnings of potential issues when providing
# care to the patient.
class Fhir::Alert < Fhir::Resource
  invariants do
    validates_presence_of :status
    validates_presence_of :subject_ref
    validates_presence_of :note
  end

  # Extensions that cannot be ignored
  attribute :modifier_extension, Array[Fhir::Extension]

  # Text summary of the resource, for human interpretation
  attribute :text, Fhir::Narrative

  # The category of this alert
  attribute :category, Fhir::CodeableConcept

  # active | inactive | entered in error
  attribute :status, Fhir::Code

  # Subject of this alert
  resource_reference :subject, [Fhir::Patient]

  # Alert creator
  resource_reference :author, [Fhir::Practitioner, Fhir::Patient, Fhir::Device]

  # Text of alert
  attribute :note, String
end


Fhir.load_extension('alert')
