# Prospective warnings of potential issues when providing
# care to the patient.
class Fhir::Alert < Fhir::Resource
  # Additional Content defined by implementations
  attribute :extension, Array[Fhir::Extension] # Extension

  # Text summary of the resource, for human interpretation
  attribute :text, Fhir::Narrative # Narrative

  # Contained, inline Resources
  attribute :contained, Array[Fhir::Resource] # Resource

  # The category of this alert
  attribute :category, Fhir::CodeableConcept # CodeableConcept

  # active | inactive | incorrect
  # Should be present
  attribute :status, Fhir::Code # code

  # Subject of this alert
  # Should be present
  attribute :subject, Fhir::ResourceReference[Fhir::Patient] # Resource(Patient)

  # Alert creator
  attribute :author, Fhir::ResourceReference[Fhir::Practitioner, Fhir::Patient, Fhir::Device] # Resource(Practitioner|Patient|Device)

  # Text of alert
  # Should be present
  attribute :note, String # string
end

