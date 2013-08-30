# An action that is performed on a patient. This can be a
# physical 'thing' like an operation, or less invasive like
# counseling or hypnotherapy.
class Fhir::Procedure < Fhir::Resource
  # Additional Content defined by implementations
  attribute :extension, Array[Fhir::Extension] # Extension

  # Text summary of the resource, for human interpretation
  attribute :text, Fhir::Narrative # Narrative

  # Contained, inline Resources
  attribute :contained, Array[Fhir::Resource] # Resource

  # Subject of this procedure
  # Should be present
  attribute :subject, Fhir::ResourceReference[Fhir::Patient] # Resource(Patient)

  # Identification of the procedure
  attribute :type, Fhir::CodeableConcept # CodeableConcept

  # Precise location details
  attribute :body_site, Array[Fhir::CodeableConcept] # CodeableConcept

  # Indications for the procedure
  attribute :indication, String # string

  # Limited to 'real' people rather than equipment.
  class Performer < Fhir::ValueObject
    # The reference to the practitioner
    attribute :person, Fhir::ResourceReference[Fhir::Practitioner] # Resource(Practitioner)

    # The role the person was in
    attribute :role, Fhir::CodeableConcept # CodeableConcept
  end

  attribute :performer, Array[Performer] # 

  # The date the procedure was performed
  attribute :date, Fhir::Period # Period

  # The encounter during which the procedure was performed
  attribute :encounter, Fhir::ResourceReference[Fhir::Encounter] # Resource(Encounter)

  # Outcome of the procedure
  attribute :outcome, String # string

  # Any report that results from the procedure
  attribute :report, Array[Fhir::ResourceReference[Fhir::DiagnosticReport]] # Resource(DiagnosticReport)

  # Complications
  attribute :complication, String # string

  # Instructions for follow up
  attribute :follow_up, String # string

  # Procedures may be related to other items such as
  # procedures or medications. For example treating wound
  # dehiscence following a previous procedure.
  class RelatedItem < Fhir::ValueObject
    # caused-by | caused
    attribute :type, Fhir::Code # code

    # The related item - e.g. a procedure
    attribute :target, Fhir::ResourceReference[Fhir::Procedure, Fhir::MedicationPrescription] # Resource(Procedure|MedicationPrescription)
  end

  attribute :related_item, Array[RelatedItem] # 

  # Procedure notes
  attribute :notes, String # string
end

