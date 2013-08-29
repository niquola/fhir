class Procedure
  include Virtus
  # Additional Content defined by implementations
  attribute :extension, Extension

  # Text summary of the resource, for human interpretation
  attribute :text, Narrative

  # Contained, inline Resources
  attribute :contained, Resource

  # Subject of this procedure
  attribute :subject, Resource(Patient)

  # Identification of the procedure
  attribute :type, CodeableConcept

  # Precise location details
  attribute :bodySite, CodeableConcept

  # Indications for the procedure
  attribute :indication, String

  # The people who performed the procedure
  attribute :performer, Performer

  class Performer
    include Virtus::ValueObject
    # The reference to the practitioner
    attribute :person, Resource(Practitioner)

    # The role the person was in
    attribute :role, CodeableConcept

  end
  # The date the procedure was performed
  attribute :date, Period

  # The encounter during which the procedure was performed
  attribute :encounter, Resource(Encounter)

  # Outcome of the procedure
  attribute :outcome, String

  # Any report that results from the procedure
  attribute :report, Resource(DiagnosticReport)

  # Complications
  attribute :complication, String

  # Instructions for follow up
  attribute :followUp, String

  # A procedure that is related to this one
  attribute :relatedItem, RelatedItem

  class RelatedItem
    include Virtus::ValueObject
    # caused-by | caused
    attribute :type, code

    # The related item - e.g. a procedure
    attribute :target, Resource(Procedure|MedicationPrescription)

  end
  # Procedure notes
  attribute :notes, String

end
