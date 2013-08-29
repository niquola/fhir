class Immunization
  attribute :extension, Extension
  attribute :text, Narrative
  attribute :contained, Resource
  attribute :date, DateTime
  attribute :vaccineType, CodeableConcept
  attribute :subject, Resource(Patient)
  attribute :refusedIndicator, boolean
  attribute :reported, boolean
  attribute :performer, Resource(Practitioner)
  attribute :requester, Resource(Practitioner)
  attribute :manufacturer, Resource(Organization)
  attribute :location, Resource(Location)
  attribute :lotNumber, String
  attribute :expirationDate, date
  attribute :site, CodeableConcept
  attribute :route, CodeableConcept
  attribute :doseQuantity, Quantity
  attribute :explanation, Explanation
  class Explanation
    attribute :reason, CodeableConcept
    attribute :refusalReason, CodeableConcept
  end
  attribute :reaction, Reaction
  class Reaction
    attribute :date, DateTime
    attribute :detail, Resource(AdverseReaction|Observation)
    attribute :reported, boolean
  end
  attribute :vaccinationProtocol, VaccinationProtocol
  class VaccinationProtocol
    attribute :doseSequence, integer
    attribute :description, String
    attribute :authority, Resource(Organization)
    attribute :series, String
    attribute :seriesDoses, integer
    attribute :doseTarget, CodeableConcept
    attribute :doseStatus, CodeableConcept
    attribute :doseStatusReason, CodeableConcept
  end
end
