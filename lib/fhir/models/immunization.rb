# Immunization event information.
class Fhir::Immunization < Fhir::Resource
  # Additional Content defined by implementations
  attribute :extension, Array[Fhir::Extension] # Extension

  # Text summary of the resource, for human interpretation
  attribute :text, Fhir::Narrative # Narrative

  # Contained, inline Resources
  attribute :contained, Array[Fhir::Resource] # Resource

  # Vaccination  Administration Date
  # Should be present
  attribute :date, DateTime # dateTime

  # Vaccine Product Administered
  # Should be present
  attribute :vaccine_type, Fhir::CodeableConcept # CodeableConcept

  # Who this immunization was adminstered to
  # Should be present
  attribute :subject, Fhir::ResourceReference[Fhir::Patient] # Resource(Patient)

  # Resual Indicator
  # Should be present
  attribute :refused_indicator, Boolean # boolean

  # If self-reported
  # Should be present
  attribute :reported, Boolean # boolean

  # Vaccine Administering Provider Name
  attribute :performer, Fhir::ResourceReference[Fhir::Practitioner] # Resource(Practitioner)

  # Vaccine Ordering Provider Name
  attribute :requester, Fhir::ResourceReference[Fhir::Practitioner] # Resource(Practitioner)

  # Vaccine Manufacturer
  attribute :manufacturer, Fhir::ResourceReference[Fhir::Organization] # Resource(Organization)

  # Vaccine Administration Facility
  attribute :location, Fhir::ResourceReference[Fhir::Location] # Resource(Location)

  # Vaccine Lot Number
  attribute :lot_number, String # string

  # Vaccine Expiration Date
  attribute :expiration_date, Date # date

  # Vaccine  Site of Administration
  attribute :site, Fhir::CodeableConcept # CodeableConcept

  # Vaccine Route of Administration
  attribute :route, Fhir::CodeableConcept # CodeableConcept

  # Vaccine dosage
  attribute :dose_quantity, Fhir::Quantity # Quantity

  # Reasons why a vaccine was administered or refused.
  class Explanation < Fhir::ValueObject
    # Administration Reasons
    attribute :reason, Array[Fhir::CodeableConcept] # CodeableConcept

    # Explanation of refusal / exemption
    attribute :refusal_reason, Array[Fhir::CodeableConcept] # CodeableConcept
  end

  attribute :explanation, Explanation # 

  # Categorical data indicating that an adverse event is
  # associated in time to an immunization.
  class Reaction < Fhir::ValueObject
    # Reaction Date
    attribute :date, DateTime # dateTime

    # Details of the reaction
    attribute :detail, Fhir::ResourceReference[Fhir::AdverseReaction, Fhir::Observation] # Resource(AdverseReaction|Observation)

    # Self-reported indicator
    attribute :reported, Boolean # boolean
  end

  attribute :reaction, Array[Reaction] # 

  # Contains information about the protocol under which the
  # vaccine was administered.
  class VaccinationProtocol < Fhir::ValueObject
    # Dose Number
    # Should be present
    attribute :dose_sequence, Integer # integer

    # Vaccine Administration Protocol Description
    attribute :description, String # string

    # Vaccine Administration Protocol Authority
    attribute :authority, Fhir::ResourceReference[Fhir::Organization] # Resource(Organization)

    # Vaccine Series
    attribute :series, String # string

    # Dose Number Recommendation
    attribute :series_doses, Integer # integer

    # Targeted Disease
    attribute :dose_target, Fhir::CodeableConcept # CodeableConcept

    # Dose Status
    # Should be present
    attribute :dose_status, Fhir::CodeableConcept # CodeableConcept

    # Dose Status Reason
    attribute :dose_status_reason, Fhir::CodeableConcept # CodeableConcept
  end

  attribute :vaccination_protocol, VaccinationProtocol # 
end

