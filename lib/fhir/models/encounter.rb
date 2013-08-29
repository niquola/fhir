# An interaction during which services are provided to the patient
class Encounter
  include Virtus
  # Additional Content defined by implementations
  attribute :extension, Extension

  # Text summary of the resource, for human interpretation
  attribute :text, Narrative

  # Contained, inline Resources
  attribute :contained, Resource

  # Identifier(s) by which this encounter is known
  attribute :identifier, Identifier

  # E.g. active, aborted, finished
  attribute :status, code

  # Inpatient | Outpatient etc
  attribute :class, code

  # Specific type of encounter
  attribute :type, CodeableConcept

  # The patient present at the encounter
  attribute :subject, Resource(Patient)

  # List of participants involved in the encounter
  attribute :participant, Participant

  class Participant
    include Virtus::ValueObject
    # Role of participant in encounter
    attribute :type, code

    # The practitioner that is involved
    attribute :practitioner, Resource(Practitioner)

  end
  # The appointment that scheduled this encounter
  attribute :fulfills, Resource(Appointment)

  # The date and time the encounter starts
  attribute :start, DateTime

  # Quantity of time the encounter lasted
  attribute :length, Duration

  # Reason the encounter takes place
  attribute :reason[x], String

  # Reason the encounter takes place
  attribute :indication, Resource(Any)

  # Indicates the urgency of the encounter
  attribute :priority, CodeableConcept

  # Details about an admission to a clinic
  attribute :hospitalization, Hospitalization

  class Hospitalization
    include Virtus::ValueObject
    # Pre-admission identifier
    attribute :preAdmissionIdentifier, Identifier

    # The location the patient came from before admission
    attribute :origin, Resource(Location)

    # Where patient was admitted from (physician referral, transfer)
    attribute :admitSource, CodeableConcept

    # Period of hospitalization
    attribute :period, Period

    # Where the patient stays during this encounter
    attribute :accomodation, Accomodation

    class Accomodation
      include Virtus::ValueObject
      # Bed
      attribute :bed, Resource(Location)

      # Period during which the patient was assigned the bed
      attribute :period, Period

    end
    # Dietary restrictions for the patient
    attribute :diet, CodeableConcept

    # Special courtesies (VIP, board member)
    attribute :specialCourtesy, CodeableConcept

    # Wheelchair, translator, stretcher, etc
    attribute :specialArrangement, CodeableConcept

    # Location the patient is discharged to
    attribute :destination, Resource(Location)

    # Disposition patient released to
    attribute :dischargeDisposition, CodeableConcept

    # Is readmission?
    attribute :reAdmission, boolean

  end
  # List of locations the patient has been at
  attribute :location, Location

  class Location
    include Virtus::ValueObject
    # The location the encounter takes place
    attribute :location, Resource(Location)

    # Time period during which the patient was present at the location
    attribute :period, Period

  end
  # Department or team providing care
  attribute :serviceProvider, Resource(Organization)

  # Another Encounter this encounter is part of
  attribute :partOf, Resource(Encounter)

end
