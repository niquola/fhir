# Allergy/Intolerance.
class Fhir::AllergyIntolerance < Fhir::Resource
  invariants do
    validates_presence_of :sensitivity_type
    validates_presence_of :status
    validates_presence_of :subject_ref
    validates_presence_of :substance_ref
  end

  # Extensions that cannot be ignored
  attribute :modifier_extension, Array[Fhir::Extension]

  # Text summary of the resource, for human interpretation
  attribute :text, Fhir::Narrative

  # External Ids for this item
  attribute :identifier, Array[Fhir::Identifier]

  # fatal | high | medium | low
  attribute :criticality, Fhir::Code

  # allergy | intolerance | unknown
  attribute :sensitivity_type, Fhir::Code

  # Date when the sensitivity was recorded
  attribute :recorded_date, DateTime

  # suspected | confirmed | refuted | resolved
  attribute :status, Fhir::Code

  # Who the sensitivity is for
  resource_reference :subject, [Fhir::Patient]

  # Who recorded the sensitivity
  resource_reference :recorder, [Fhir::Practitioner, Fhir::Patient]

  # The substance that causes the sensitivity
  resource_reference :substance, [Fhir::Substance]

  # Reactions associated with the sensitivity
  resource_references :reaction, [Fhir::AdverseReaction]

  # Observations that confirm or refute
  resource_references :sensitivity_test, [Fhir::Observation]
end


Fhir.load_extension('allergy_intolerance')
