# An action that is performed on a patient. This can be a
# physical 'thing' like an operation, or less invasive like
# counseling or hypnotherapy.
class Fhir::Procedure < Fhir::Resource
  invariants do
    validates_presence_of :subject_ref
    validates_presence_of :type
  end

  # Extensions that cannot be ignored
  attribute :modifier_extension, Array[Fhir::Extension]

  # Text summary of the resource, for human interpretation
  attribute :text, Fhir::Narrative

  # External Ids for this procedure
  attribute :identifier, Array[Fhir::Identifier]

  # Subject of this procedure
  resource_reference :subject, [Fhir::Patient]

  # Identification of the procedure
  attribute :type, Fhir::CodeableConcept

  # Precise location details
  attribute :body_site, Array[Fhir::CodeableConcept]

  # Reason procedure performed
  attribute :indication, Array[Fhir::CodeableConcept]

  # Limited to 'real' people rather than equipment.
  class Performer < Fhir::ValueObject
    # Extensions that cannot be ignored
    attribute :modifier_extension, Array[Fhir::Extension]

    # The reference to the practitioner
    resource_reference :person, [Fhir::Practitioner]

    # The role the person was in
    attribute :role, Fhir::CodeableConcept
  end

  attribute :performer, Array[Performer]

  # The date the procedure was performed
  attribute :date, Fhir::Period

  # The encounter when procedure performed
  resource_reference :encounter, [Fhir::Encounter]

  # Outcome of the procedure
  attribute :outcome, String

  # Any report that results from the procedure
  resource_references :report, [Fhir::DiagnosticReport]

  # Complication following the procedure
  attribute :complication, Array[Fhir::CodeableConcept]

  # Instructions for follow up
  attribute :follow_up, String

  # Procedures may be related to other items such as
  # procedures or medications. For example treating wound
  # dehiscence following a previous procedure.
  class RelatedItem < Fhir::ValueObject
    # Extensions that cannot be ignored
    attribute :modifier_extension, Array[Fhir::Extension]

    # caused-by | because-of
    attribute :type, Fhir::Code

    # The related item - e.g. a procedure
    resource_reference :target, [Fhir::AdverseReaction, Fhir::AllergyIntolerance, Fhir::CarePlan, Fhir::Condition, Fhir::DeviceObservationReport, Fhir::DiagnosticReport, Fhir::FamilyHistory, Fhir::ImagingStudy, Fhir::Immunization, Fhir::ImmunizationRecommendation, Fhir::MedicationAdministration, Fhir::MedicationDispense, Fhir::MedicationPrescription, Fhir::MedicationStatement, Fhir::Observation, Fhir::Procedure]
  end

  attribute :related_item, Array[RelatedItem]

  # Procedure notes
  attribute :notes, String
end


Fhir.load_extension('procedure')
