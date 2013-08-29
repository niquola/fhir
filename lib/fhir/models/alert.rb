# Alert
class Alert
  include Virtus
  # Additional Content defined by implementations
  attribute :extension, Extension

  # Text summary of the resource, for human interpretation
  attribute :text, Narrative

  # Contained, inline Resources
  attribute :contained, Resource

  # The category of this alert
  attribute :category, CodeableConcept

  # active | inactive | incorrect
  attribute :status, code

  # Subject of this alert
  attribute :subject, Resource(Patient)

  # Alert creator
  attribute :author, Resource(Practitioner|Patient|Device)

  # Text of alert
  attribute :note, String

end
