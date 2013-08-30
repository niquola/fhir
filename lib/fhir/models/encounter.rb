# An interaction between a patient and healthcare
# provider(s) for the purpose of providing healthcare
# service(s) or assessing the health status of a patient.
class Fhir::Encounter < Fhir::Resource
  # Additional Content defined by implementations
  attribute :extension, Array[Fhir::Extension] # Extension

  # Text summary of the resource, for human interpretation
  attribute :text, Fhir::Narrative # Narrative

  # Contained, inline Resources
  attribute :contained, Array[Fhir::Resource] # Resource

  # Identifier(s) by which this encounter is known
  attribute :identifier, Array[Fhir::Identifier] # Identifier

  # E.g. active, aborted, finished
  # Should be present
  attribute :status, Fhir::Code # code

  # Inpatient | Outpatient etc
  # Should be present
  attribute :class, Fhir::Code # code

  # Specific type of encounter
  attribute :type, Array[Fhir::CodeableConcept] # CodeableConcept

  # The patient present at the encounter
  attribute :subject, Fhir::ResourceReference[Fhir::Patient] # Resource(Patient)

  # The main practitioner responsible for providing the
  # service.
  class Participant < Fhir::ValueObject
    # Role of participant in encounter
    attribute :type, Array[Fhir::Code] # code

    # The practitioner that is involved
    attribute :practitioner, Fhir::ResourceReference[Fhir::Practitioner] # Resource(Practitioner)
  end

  attribute :participant, Array[Participant] # 

  # The appointment that scheduled this encounter
  attribute :fulfills, Fhir::ResourceReference # Resource(Appointment)

  # The date and time the encounter starts
  attribute :start, DateTime # dateTime

  # Quantity of time the encounter lasted
  attribute :length, Fhir::Quantity # Duration

  # Reason the encounter takes place
  attribute :reason, String # string

  # Reason the encounter takes place
  attribute :indication, Fhir::ResourceReference # Resource(Any)

  # Indicates the urgency of the encounter
  attribute :priority, Fhir::CodeableConcept # CodeableConcept

  # Details about an admission to a clinic.
  class Hospitalization < Fhir::ValueObject
    # Pre-admission identifier
    attribute :pre_admission_identifier, Fhir::Identifier # Identifier

    # The location the patient came from before admission
    attribute :origin, Fhir::ResourceReference[Fhir::Location] # Resource(Location)

    # Where patient was admitted from (physician referral,
    # transfer)
    attribute :admit_source, Fhir::CodeableConcept # CodeableConcept

    # Period of hospitalization
    attribute :period, Fhir::Period # Period

    # Where the patient stays during this encounter.
    class Accomodation < Fhir::ValueObject
      # Bed
      attribute :bed, Fhir::ResourceReference[Fhir::Location] # Resource(Location)

      # Period during which the patient was assigned the bed
      attribute :period, Fhir::Period # Period
    end

    attribute :accomodation, Array[Accomodation] # 

    # Dietary restrictions for the patient
    attribute :diet, Fhir::CodeableConcept # CodeableConcept

    # Special courtesies (VIP, board member)
    attribute :special_courtesy, Array[Fhir::CodeableConcept] # CodeableConcept

    # Wheelchair, translator, stretcher, etc
    attribute :special_arrangement, Array[Fhir::CodeableConcept] # CodeableConcept

    # Location the patient is discharged to
    attribute :destination, Fhir::ResourceReference[Fhir::Location] # Resource(Location)

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
    attribute :location, Fhir::ResourceReference[Fhir::Location] # Resource(Location)

    # Time period during which the patient was present at the
    # location
    # Should be present
    attribute :period, Fhir::Period # Period
  end

  attribute :location, Array[Location] # 

  # Department or team providing care
  attribute :service_provider, Fhir::ResourceReference[Fhir::Organization] # Resource(Organization)

  # Another Encounter this encounter is part of
  attribute :part_of, Fhir::ResourceReference[Fhir::Encounter] # Resource(Encounter)
end

