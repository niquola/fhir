class Encounter
  attribute :extension, Extension
  attribute :text, Narrative
  attribute :contained, Resource
  attribute :identifier, Identifier
  attribute :status, code
  attribute :class, code
  attribute :type, CodeableConcept
  attribute :subject, Resource(Patient)
  attribute :participant, Participant
  class Participant
    attribute :type, code
    attribute :practitioner, Resource(Practitioner)
  end
  attribute :fulfills, Resource(Appointment)
  attribute :start, DateTime
  attribute :length, Duration
  attribute :reason[x], String
  attribute :indication, Resource(Any)
  attribute :priority, CodeableConcept
  attribute :hospitalization, Hospitalization
  class Hospitalization
    attribute :preAdmissionIdentifier, Identifier
    attribute :origin, Resource(Location)
    attribute :admitSource, CodeableConcept
    attribute :period, Period
    attribute :accomodation, Accomodation
    class Accomodation
      attribute :bed, Resource(Location)
      attribute :period, Period
    end
    attribute :diet, CodeableConcept
    attribute :specialCourtesy, CodeableConcept
    attribute :specialArrangement, CodeableConcept
    attribute :destination, Resource(Location)
    attribute :dischargeDisposition, CodeableConcept
    attribute :reAdmission, boolean
  end
  attribute :location, Location
  class Location
    attribute :location, Resource(Location)
    attribute :period, Period
  end
  attribute :serviceProvider, Resource(Organization)
  attribute :partOf, Resource(Encounter)
end
