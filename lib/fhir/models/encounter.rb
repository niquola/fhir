# An interaction between a patient and healthcare
# provider(s) for the purpose of providing healthcare
# service(s) or assessing the health status of a patient.
class Fhir::Encounter < Fhir::Resource
  # Additional Content defined by implementations
  attribute :extension, Array[Extension]

  # Text summary of the resource, for human interpretation
  attribute :text, Narrative

  # Contained, inline Resources
  attribute :contained, Array[ResourceLink[Resource]]

  # Identifier(s) by which this encounter is known
  attribute :identifier, Array[Identifier]

  # E.g. active, aborted, finished
  # Should be present
  attribute :status, code

  # Inpatient | Outpatient etc
  # Should be present
  attribute :class, code

  # Specific type of encounter
  attribute :type, Array[CodeableConcept]

  # The patient present at the encounter
  attribute :subject, ResourceLink[Patient]

  # The main practitioner responsible for providing the
  # service.
  class Participant < Fhir::ValueObject
    # Role of participant in encounter
    attribute :type, Array[code]

    # The practitioner that is involved
    attribute :practitioner, ResourceLink[Practitioner]
  end

  attribute :participant, Array[Participant]

  # The appointment that scheduled this encounter
  attribute :fulfills, ResourceLink[Appointment]

  # The date and time the encounter starts
  attribute :start, dateTime

  # Quantity of time the encounter lasted
  attribute :length, Duration

  # Reason the encounter takes place
  attribute :reason[x], string

  # Reason the encounter takes place
  attribute :indication, ResourceLink[Any]

  # Indicates the urgency of the encounter
  attribute :priority, CodeableConcept

  # Details about an admission to a clinic.
  class Hospitalization < Fhir::ValueObject
    # Pre-admission identifier
    attribute :pre_admission_identifier, Identifier

    # The location the patient came from before admission
    attribute :origin, ResourceLink[Location]

    # Where patient was admitted from (physician referral,
    # transfer)
    attribute :admit_source, CodeableConcept

    # Period of hospitalization
    attribute :period, Period

    # Where the patient stays during this encounter.
    class Accomodation < Fhir::ValueObject
      # Bed
      attribute :bed, ResourceLink[Location]

      # Period during which the patient was assigned the bed
      attribute :period, Period
    end

    attribute :accomodation, Array[Accomodation]

    # Dietary restrictions for the patient
    attribute :diet, CodeableConcept

    # Special courtesies (VIP, board member)
    attribute :special_courtesy, Array[CodeableConcept]

    # Wheelchair, translator, stretcher, etc
    attribute :special_arrangement, Array[CodeableConcept]

    # Location the patient is discharged to
    attribute :destination, ResourceLink[Location]

    # Disposition patient released to
    attribute :discharge_disposition, CodeableConcept

    # Is readmission?
    attribute :re_admission, boolean
  end

  attribute :hospitalization, Hospitalization

  # List of locations the patient has been at.
  class Location < Fhir::ValueObject
    # The location the encounter takes place
    # Should be present
    attribute :location, ResourceLink[Location]

    # Time period during which the patient was present at the
    # location
    # Should be present
    attribute :period, Period
  end

  attribute :location, Array[Location]

  # Department or team providing care
  attribute :service_provider, ResourceLink[Organization]

  # Another Encounter this encounter is part of
  attribute :part_of, ResourceLink[Encounter]
end

