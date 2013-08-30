# Immunization event information.
class Fhir::Immunization < Fhir::Resource
  # Additional Content defined by implementations
  attribute :extension, Array[Extension]

  # Text summary of the resource, for human interpretation
  attribute :text, Narrative

  # Contained, inline Resources
  attribute :contained, Array[ResourceLink[Resource]]

  # Vaccination  Administration Date
  # Should be present
  attribute :date, dateTime

  # Vaccine Product Administered
  # Should be present
  attribute :vaccine_type, CodeableConcept

  # Who this immunization was adminstered to
  # Should be present
  attribute :subject, ResourceLink[Patient]

  # Resual Indicator
  # Should be present
  attribute :refused_indicator, boolean

  # If self-reported
  # Should be present
  attribute :reported, boolean

  # Vaccine Administering Provider Name
  attribute :performer, ResourceLink[Practitioner]

  # Vaccine Ordering Provider Name
  attribute :requester, ResourceLink[Practitioner]

  # Vaccine Manufacturer
  attribute :manufacturer, ResourceLink[Organization]

  # Vaccine Administration Facility
  attribute :location, ResourceLink[Location]

  # Vaccine Lot Number
  attribute :lot_number, string

  # Vaccine Expiration Date
  attribute :expiration_date, date

  # Vaccine  Site of Administration
  attribute :site, CodeableConcept

  # Vaccine Route of Administration
  attribute :route, CodeableConcept

  # Vaccine dosage
  attribute :dose_quantity, Quantity

  # Reasons why a vaccine was administered or refused.
  class Explanation < Fhir::ValueObject
    # Administration Reasons
    attribute :reason, Array[CodeableConcept]

    # Explanation of refusal / exemption
    attribute :refusal_reason, Array[CodeableConcept]
  end

  attribute :explanation, Explanation

  # Categorical data indicating that an adverse event is
  # associated in time to an immunization.
  class Reaction < Fhir::ValueObject
    # Reaction Date
    attribute :date, dateTime

    # Details of the reaction
    attribute :detail, ResourceLink[AdverseReaction, Observation]

    # Self-reported indicator
    attribute :reported, boolean
  end

  attribute :reaction, Array[Reaction]

  # Contains information about the protocol under which the
  # vaccine was administered.
  class VaccinationProtocol < Fhir::ValueObject
    # Dose Number
    # Should be present
    attribute :dose_sequence, integer

    # Vaccine Administration Protocol Description
    attribute :description, string

    # Vaccine Administration Protocol Authority
    attribute :authority, ResourceLink[Organization]

    # Vaccine Series
    attribute :series, string

    # Dose Number Recommendation
    attribute :series_doses, integer

    # Targeted Disease
    attribute :dose_target, CodeableConcept

    # Dose Status
    # Should be present
    attribute :dose_status, CodeableConcept

    # Dose Status Reason
    attribute :dose_status_reason, CodeableConcept
  end

  attribute :vaccination_protocol, VaccinationProtocol
end

