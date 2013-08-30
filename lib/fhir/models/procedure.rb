# An action that is performed on a patient. This can be a
# physical 'thing' like an operation, or less invasive like
# counseling or hypnotherapy.
class Fhir::Procedure < Fhir::Resource
  # Additional Content defined by implementations
  attribute :extension, Array[Extension]

  # Text summary of the resource, for human interpretation
  attribute :text, Narrative

  # Contained, inline Resources
  attribute :contained, Array[ResourceLink[Resource]]

  # Subject of this procedure
  # Should be present
  attribute :subject, ResourceLink[Patient]

  # Identification of the procedure
  attribute :type, CodeableConcept

  # Precise location details
  attribute :body_site, Array[CodeableConcept]

  # Indications for the procedure
  attribute :indication, string

  # Limited to 'real' people rather than equipment.
  class Performer < Fhir::ValueObject
    # The reference to the practitioner
    attribute :person, ResourceLink[Practitioner]

    # The role the person was in
    attribute :role, CodeableConcept
  end

  attribute :performer, Array[Performer]

  # The date the procedure was performed
  attribute :date, Period

  # The encounter during which the procedure was performed
  attribute :encounter, ResourceLink[Encounter]

  # Outcome of the procedure
  attribute :outcome, string

  # Any report that results from the procedure
  attribute :report, Array[ResourceLink[DiagnosticReport]]

  # Complications
  attribute :complication, string

  # Instructions for follow up
  attribute :follow_up, string

  # Procedures may be related to other items such as
  # procedures or medications. For example treating wound
  # dehiscence following a previous procedure.
  class RelatedItem < Fhir::ValueObject
    # caused-by | caused
    attribute :type, code

    # The related item - e.g. a procedure
    attribute :target, ResourceLink[Procedure, MedicationPrescription]
  end

  attribute :related_item, Array[RelatedItem]

  # Procedure notes
  attribute :notes, string
end

