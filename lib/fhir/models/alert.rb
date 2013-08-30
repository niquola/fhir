# Prospective warnings of potential issues when providing
# care to the patient.
class Fhir::Alert < Fhir::Resource
  # Additional Content defined by implementations
  attribute :extension, Array[Extension]

  # Text summary of the resource, for human interpretation
  attribute :text, Narrative

  # Contained, inline Resources
  attribute :contained, Array[ResourceLink[Resource]]

  # The category of this alert
  attribute :category, CodeableConcept

  # active | inactive | incorrect
  # Should be present
  attribute :status, code

  # Subject of this alert
  # Should be present
  attribute :subject, ResourceLink[Patient]

  # Alert creator
  attribute :author, ResourceLink[Practitioner, Patient, Device]

  # Text of alert
  # Should be present
  attribute :note, string
end

