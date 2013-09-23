# An action that is performed on a patient. This can be a
# physical 'thing' like an operation, or less invasive like
# counseling or hypnotherapy.
class Fhir::Procedure < Fhir::Resource
  invariants do
    validates_presence_of :subject_ref
  end

  # Text summary of the resource, for human interpretation
  attribute :text, Fhir::Narrative

  # Subject of this procedure
  resource_reference :subject, [Fhir::Patient]

  # Identification of the procedure
  attribute :type, Fhir::CodeableConcept

  # Precise location details
  attribute :body_sites, Array[Fhir::CodeableConcept]

  # Indications for the procedure
  attribute :indication, String

  # Limited to 'real' people rather than equipment.
  class Performer < Fhir::ValueObject
    # The reference to the practitioner
    resource_reference :person, [Fhir::Practitioner]

    # The role the person was in
    attribute :role, Fhir::CodeableConcept
  end

  attribute :performers, Array[Performer]

  # The date the procedure was performed
  attribute :date, Fhir::Period

  # The encounter during which the procedure was performed
  resource_reference :encounter, [Fhir::Encounter]

  # Outcome of the procedure
  attribute :outcome, String

  # Any report that results from the procedure
  resource_references :reports, [Fhir::DiagnosticReport]

  # Complications
  attribute :complication, String

  # Instructions for follow up
  attribute :follow_up, String

  # Procedures may be related to other items such as
  # procedures or medications. For example treating wound
  # dehiscence following a previous procedure.
  class RelatedItem < Fhir::ValueObject
    # caused-by | caused
    attribute :type, Fhir::Code

    # The related item - e.g. a procedure
    resource_reference :target, [Fhir::Procedure, Fhir::MedicationPrescription]
  end

  attribute :related_items, Array[RelatedItem]

  # Procedure notes
  attribute :notes, String
end


Fhir.load_extension('procedure')
