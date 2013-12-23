# An interaction between a patient and healthcare
# provider(s) for the purpose of providing healthcare
# service(s) or assessing the health status of a patient.
class Fhir::Encounter < Fhir::Resource
  invariants do
    validates_presence_of :status
    validates_presence_of :encounter_class
  end

  # Extensions that cannot be ignored
  attribute :modifier_extension, Array[Fhir::Extension]

  # Text summary of the resource, for human interpretation
  attribute :text, Fhir::Narrative

  # Identifier(s) by which this encounter is known
  attribute :identifier, Array[Fhir::Identifier]

  # planned | in progress | onleave | finished | cancelled
  attribute :status, Fhir::Code

  # inpatient | outpatient | ambulatory | emergency +
  attribute :encounter_class, Fhir::Code

  # Specific type of encounter
  attribute :type, Array[Fhir::CodeableConcept]

  # The patient present at the encounter
  resource_reference :subject, [Fhir::Patient]

  # The main practitioner responsible for providing the
  # service.
  class Participant < Fhir::ValueObject
    # Extensions that cannot be ignored
    attribute :modifier_extension, Array[Fhir::Extension]

    # Role of participant in encounter
    attribute :type, Array[Fhir::CodeableConcept]

    # Persons involved in the encounter other than the patient
    resource_reference :individual, [Fhir::Practitioner, Fhir::RelatedPerson]
  end

  attribute :participant, Array[Participant]

  # The start and end time of the encounter
  attribute :period, Fhir::Period

  # Quantity of time the encounter lasted
  attribute :length, Fhir::Quantity

  # Reason the encounter takes place (code)
  attribute :reason, Fhir::CodeableConcept

  # Reason the encounter takes place (resource)
  resource_reference :indication, [Fhir::Resource]

  # Indicates the urgency of the encounter
  attribute :priority, Fhir::CodeableConcept

  # Details about an admission to a clinic.
  class Hospitalization < Fhir::ValueObject
    # Extensions that cannot be ignored
    attribute :modifier_extension, Array[Fhir::Extension]

    # Pre-admission identifier
    attribute :pre_admission_identifier, Fhir::Identifier

    # The location the patient came from before admission
    resource_reference :origin, [Fhir::Location]

    # Where patient was admitted from (physician referral,
    # transfer)
    attribute :admit_source, Fhir::CodeableConcept

    # Period during which the patient was admitted
    attribute :period, Fhir::Period

    # Where the patient stays during this encounter.
    class Accomodation < Fhir::ValueObject
      # Extensions that cannot be ignored
      attribute :modifier_extension, Array[Fhir::Extension]

      # The bed that is assigned to the patient
      resource_reference :bed, [Fhir::Location]

      # Period during which the patient was assigned the bed
      attribute :period, Fhir::Period
    end

    attribute :accomodation, Array[Accomodation]

    # Dietary restrictions for the patient
    attribute :diet, Fhir::CodeableConcept

    # Special courtesies (VIP, board member)
    attribute :special_courtesy, Array[Fhir::CodeableConcept]

    # Wheelchair, translator, stretcher, etc
    attribute :special_arrangement, Array[Fhir::CodeableConcept]

    # Location the patient is discharged to
    resource_reference :destination, [Fhir::Location]

    # Disposition patient released to
    attribute :discharge_disposition, Fhir::CodeableConcept

    # The final diagnosis given a patient before release from
    # the hospital after all testing, surgery, and workup are
    # complete
    resource_reference :discharge_diagnosis, [Fhir::Resource]

    # Is this hospitalization a readmission?
    attribute :re_admission, Boolean
  end

  attribute :hospitalization, Hospitalization

  # List of locations the patient has been at.
  class Location < Fhir::ValueObject
    invariants do
      validates_presence_of :location_ref
      validates_presence_of :period
    end

    # Extensions that cannot be ignored
    attribute :modifier_extension, Array[Fhir::Extension]

    # The location the encounter takes place
    resource_reference :location, [Fhir::Location]

    # Time period during which the patient was present at the
    # location
    attribute :period, Fhir::Period
  end

  attribute :location, Array[Location]

  # Department or team providing care
  resource_reference :service_provider, [Fhir::Organization]

  # Another Encounter this encounter is part of
  resource_reference :part_of, [Fhir::Encounter]
end


Fhir.load_extension('encounter')
