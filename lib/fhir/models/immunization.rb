# Immunization event information.
class Fhir::Immunization < Fhir::Resource
  invariants do
    validates_presence_of :date
    validates_presence_of :vaccine_type
    validates_presence_of :subject_ref
    validates_inclusion_of :refused_indicator, in: [true, false], message: 'must be either true or false'
    validates_inclusion_of :reported, in: [true, false], message: 'must be either true or false'
  end

  # Extensions that cannot be ignored
  attribute :modifier_extension, Array[Fhir::Extension]

  # Text summary of the resource, for human interpretation
  attribute :text, Fhir::Narrative

  # Vaccination  Administration Date
  attribute :date, DateTime

  # Vaccine Product Administered
  attribute :vaccine_type, Fhir::CodeableConcept

  # Who this immunization was adminstered to
  resource_reference :subject, [Fhir::Patient]

  # Resual Indicator
  attribute :refused_indicator, Boolean

  # If self-reported
  attribute :reported, Boolean

  # Vaccine Administering Provider Name
  resource_reference :performer, [Fhir::Practitioner]

  # Vaccine Ordering Provider Name
  resource_reference :requester, [Fhir::Practitioner]

  # Vaccine Manufacturer
  resource_reference :manufacturer, [Fhir::Organization]

  # Vaccine Administration Facility
  resource_reference :location, [Fhir::Location]

  # Vaccine Lot Number
  attribute :lot_number, String

  # Vaccine Expiration Date
  attribute :expiration_date, Date

  # Vaccine  Site of Administration
  attribute :site, Fhir::CodeableConcept

  # Vaccine Route of Administration
  attribute :route, Fhir::CodeableConcept

  # Vaccine dosage
  attribute :dose_quantity, Fhir::Quantity

  # Reasons why a vaccine was administered or refused.
  class Explanation < Fhir::ValueObject
    # Extensions that cannot be ignored
    attribute :modifier_extension, Array[Fhir::Extension]

    # Administration Reasons
    attribute :reason, Array[Fhir::CodeableConcept]

    # Explanation of refusal / exemption
    attribute :refusal_reason, Array[Fhir::CodeableConcept]
  end

  attribute :explanation, Explanation

  # Categorical data indicating that an adverse event is
  # associated in time to an immunization.
  class Reaction < Fhir::ValueObject
    # Extensions that cannot be ignored
    attribute :modifier_extension, Array[Fhir::Extension]

    # Reaction Date
    attribute :date, DateTime

    # Details of the reaction
    resource_reference :detail, [Fhir::AdverseReaction, Fhir::Observation]

    # Self-reported indicator
    attribute :reported, Boolean
  end

  attribute :reaction, Array[Reaction]

  # Contains information about the protocol under which the
  # vaccine was administered.
  class VaccinationProtocol < Fhir::ValueObject
    invariants do
      validates_presence_of :dose_sequence
      validates_presence_of :dose_status
    end

    # Extensions that cannot be ignored
    attribute :modifier_extension, Array[Fhir::Extension]

    # Dose Number
    attribute :dose_sequence, Integer

    # Vaccine Administration Protocol Description
    attribute :description, String

    # Vaccine Administration Protocol Authority
    resource_reference :authority, [Fhir::Organization]

    # Vaccine Series
    attribute :series, String

    # Dose Number Recommendation
    attribute :series_doses, Integer

    # Targeted Disease
    attribute :dose_target, Fhir::CodeableConcept

    # Dose Status
    attribute :dose_status, Fhir::CodeableConcept

    # Dose Status Reason
    attribute :dose_status_reason, Fhir::CodeableConcept
  end

  attribute :vaccination_protocol, VaccinationProtocol
end


Fhir.load_extension('immunization')
