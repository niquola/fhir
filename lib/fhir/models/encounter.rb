# An interaction between a patient and healthcare
# provider(s) for the purpose of providing healthcare
# service(s) or assessing the health status of a patient.
class Fhir::Encounter < Fhir::Resource
  # Identifier(s) by which this encounter is known
  attribute :identifiers, Array[Fhir::Identifier] # Identifier

  # E.g. active, aborted, finished
  # Should be present
  attribute :status, Fhir::Code # code

  # Inpatient | Outpatient etc
  # Should be present
  attribute :class, Fhir::Code # code

  # Specific type of encounter
  attribute :types, Array[Fhir::CodeableConcept] # CodeableConcept

  # The patient present at the encounter
  resource_reference :subject, [Fhir::Patient]

  # The main practitioner responsible for providing the
  # service.
  class Participant < Fhir::ValueObject
    # Role of participant in encounter
    attribute :types, Array[Fhir::Code] # code

    # The practitioner that is involved
    resource_reference :practitioner, [Fhir::Practitioner]
  end

  attribute :participants, Array[Participant] # 

  # The appointment that scheduled this encounter
  resource_reference :fulfills, [Fhir::Resource]

  # The date and time the encounter starts
  attribute :start, DateTime # dateTime

  # Quantity of time the encounter lasted
  attribute :length, Fhir::Quantity # Duration

  # Reason the encounter takes place
  attribute :reason, String # string

  # Reason the encounter takes place
  resource_reference :indication, [Fhir::Resource]

  # Indicates the urgency of the encounter
  attribute :priority, Fhir::CodeableConcept # CodeableConcept

  # Details about an admission to a clinic.
  class Hospitalization < Fhir::ValueObject
    # Pre-admission identifier
    attribute :pre_admission_identifier, Fhir::Identifier # Identifier

    # The location the patient came from before admission
    resource_reference :origin, [Fhir::Location]

    # Where patient was admitted from (physician referral,
    # transfer)
    attribute :admit_source, Fhir::CodeableConcept # CodeableConcept

    # Period of hospitalization
    attribute :period, Fhir::Period # Period

    # Where the patient stays during this encounter.
    class Accomodation < Fhir::ValueObject
      # Bed
      resource_reference :bed, [Fhir::Location]

      # Period during which the patient was assigned the bed
      attribute :period, Fhir::Period # Period
    end

    attribute :accomodations, Array[Accomodation] # 

    # Dietary restrictions for the patient
    attribute :diet, Fhir::CodeableConcept # CodeableConcept

    # Special courtesies (VIP, board member)
    attribute :special_courtesies, Array[Fhir::CodeableConcept] # CodeableConcept

    # Wheelchair, translator, stretcher, etc
    attribute :special_arrangements, Array[Fhir::CodeableConcept] # CodeableConcept

    # Location the patient is discharged to
    resource_reference :destination, [Fhir::Location]

    # Disposition patient released to
    attribute :discharge_disposition, Fhir::CodeableConcept # CodeableConcept

    # Is readmission?
    attribute :re_admission, Boolean # boolean
  end

  attribute :hospitalization, Hospitalization # 

  # List of locations the patient has been at.
  class Location < Fhir::ValueObject
    # The location the encounter takes place
    # Should be present
    resource_reference :location, [Fhir::Location]

    # Time period during which the patient was present at the
    # location
    # Should be present
    attribute :period, Fhir::Period # Period
  end

  attribute :locations, Array[Location] # 

  # Department or team providing care
  resource_reference :service_provider, [Fhir::Organization]

  # Another Encounter this encounter is part of
  resource_reference :part_of, [Fhir::Encounter]
end

