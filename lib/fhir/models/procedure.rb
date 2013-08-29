class Procedure
  attribute :extension, Extension
  attribute :text, Narrative
  attribute :contained, Resource
  attribute :subject, Resource(Patient)
  attribute :type, CodeableConcept
  attribute :bodySite, CodeableConcept
  attribute :indication, String
  attribute :performer, Performer
  class Performer
    attribute :person, Resource(Practitioner)
    attribute :role, CodeableConcept
  end
  attribute :date, Period
  attribute :encounter, Resource(Encounter)
  attribute :outcome, String
  attribute :report, Resource(DiagnosticReport)
  attribute :complication, String
  attribute :followUp, String
  attribute :relatedItem, RelatedItem
  class RelatedItem
    attribute :type, code
    attribute :target, Resource(Procedure|MedicationPrescription)
  end
  attribute :notes, String
end
