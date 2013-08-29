class Immunization
  include Virtus
  # Additional Content defined by implementations
  attribute :extension, Extension

  # Text summary of the resource, for human interpretation
  attribute :text, Narrative

  # Contained, inline Resources
  attribute :contained, Resource

  # Vaccination  Administration Date
  attribute :date, DateTime

  # Vaccine Product Administered
  attribute :vaccineType, CodeableConcept

  # Who this immunization was adminstered to
  attribute :subject, Resource(Patient)

  # Resual Indicator
  attribute :refusedIndicator, boolean

  # If self-reported
  attribute :reported, boolean

  # Vaccine Administering Provider Name
  attribute :performer, Resource(Practitioner)

  # Vaccine Ordering Provider Name
  attribute :requester, Resource(Practitioner)

  # Vaccine Manufacturer
  attribute :manufacturer, Resource(Organization)

  # Vaccine Administration Facility
  attribute :location, Resource(Location)

  # Vaccine Lot Number
  attribute :lotNumber, String

  # Vaccine Expiration Date
  attribute :expirationDate, date

  # Vaccine  Site of Administration
  attribute :site, CodeableConcept

  # Vaccine Route of Administration
  attribute :route, CodeableConcept

  # Vaccine dosage
  attribute :doseQuantity, Quantity

  # Administration / Refusal Reasons
  attribute :explanation, Explanation

  class Explanation
    include Virtus::ValueObject
    # Administration Reasons
    attribute :reason, CodeableConcept

    # Explanation of refusal / exemption
    attribute :refusalReason, CodeableConcept

  end
  # Details of a reaction that follows immunization
  attribute :reaction, Reaction

  class Reaction
    include Virtus::ValueObject
    # Reaction Date
    attribute :date, DateTime

    # Details of the reaction
    attribute :detail, Resource(AdverseReaction|Observation)

    # Self-reported indicator
    attribute :reported, boolean

  end
  # Vaccine Administration Protocol
  attribute :vaccinationProtocol, VaccinationProtocol

  class VaccinationProtocol
    include Virtus::ValueObject
    # Dose Number
    attribute :doseSequence, integer

    # Vaccine Administration Protocol Description
    attribute :description, String

    # Vaccine Administration Protocol Authority
    attribute :authority, Resource(Organization)

    # Vaccine Series
    attribute :series, String

    # Dose Number Recommendation
    attribute :seriesDoses, integer

    # Targeted Disease
    attribute :doseTarget, CodeableConcept

    # Dose Status
    attribute :doseStatus, CodeableConcept

    # Dose Status Reason
    attribute :doseStatusReason, CodeableConcept

  end
end
