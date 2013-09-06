# Prospective warnings of potential issues when providing
# care to the patient.
class Fhir::Alert < Fhir::Resource
  invariants do
    validates_presence_of :status
    validates_presence_of :subject_ref
    validates_presence_of :note
  end

  # Text summary of the resource, for human interpretation
  attribute :text, Fhir::Narrative

  # The category of this alert
  attribute :category, Fhir::CodeableConcept

  # active | inactive | incorrect
  # Should be present
  attribute :status, Fhir::Code

  # Subject of this alert
  # Should be present
  resource_reference :subject, [Fhir::Patient]

  # Alert creator
  resource_reference :author, [Fhir::Practitioner, Fhir::Patient, Fhir::Device]

  # Text of alert
  # Should be present
  attribute :note, String
end

