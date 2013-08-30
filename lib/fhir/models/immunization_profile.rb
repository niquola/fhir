# A patient's point-of-time immunization status and
# recommendation with optional supporting justification.
class Fhir::ImmunizationProfile < Fhir::Resource
  # Additional Content defined by implementations
  attribute :extension, Array[Fhir::Extension] # Extension

  # Text summary of the resource, for human interpretation
  attribute :text, Fhir::Narrative # Narrative

  # Contained, inline Resources
  attribute :contained, Array[Fhir::Resource] # Resource

  # Who this profile is for
  # Should be present
  attribute :subject, Fhir::ResourceReference[Fhir::Patient] # Resource(Patient)

  # Vaccine administration recommendations.
  class Recommendation < Fhir::ValueObject
    # Recommendation date
    # Should be present
    attribute :recommendation_date, DateTime # dateTime

    # Vaccine that pertains to the recommendation
    # Should be present
    attribute :vaccine_type, Fhir::CodeableConcept # CodeableConcept

    # Recommended dose number
    attribute :dose_number, Integer # integer

    # Vaccine administration status
    # Should be present
    attribute :forecast_status, Fhir::Code # code

    # Vaccine date recommentations - e.g. earliest date to
    # administer, latest date to administer, etc.
    class DateCriterion < Fhir::ValueObject
      # Date classification of recommendation
      # Should be present
      attribute :code, Fhir::CodeableConcept # CodeableConcept

      # Date recommendation
      # Should be present
      attribute :value, DateTime # dateTime
    end

    attribute :date_criterion, Array[DateCriterion] # 

    # Contains information about the protocol under which the
    # vaccine was administered.
    class Protocol < Fhir::ValueObject
      # Dose Number
      attribute :dose_sequence, Integer # integer

      # Vaccine Administration Protocol Description
      attribute :description, String # string

      # Vaccine Administration Protocol Authority
      attribute :authority, Fhir::ResourceReference[Fhir::Organization] # Resource(Organization)

      # Vaccine Series
      attribute :series, String # string
    end

    attribute :protocol, Protocol # 

    # Supporting Immunization
    attribute :supporting_immunization, Array[Fhir::ResourceReference[Fhir::Immunization]] # Resource(Immunization)

    # Adverse event report information that supports the status
    # and recommendation.
    class SupportingAdverseEventReport < Fhir::ValueObject
      # Adverse event report identifier
      # Should be present
      attribute :identifier, Array[String] # id

      # Adverse event report classification
      attribute :report_type, Fhir::CodeableConcept # CodeableConcept

      # Adverse event report date
      attribute :report_date, DateTime # dateTime

      # Adverse event report text
      attribute :text, String # string

      # Documented reaction
      attribute :reaction, Array[Fhir::ResourceReference[Fhir::AdverseReaction]] # Resource(AdverseReaction)
    end

    attribute :supporting_adverse_event_report, Array[SupportingAdverseEventReport] # 

    # Supporting Patient Observation
    attribute :supporting_patient_observation, Array[Fhir::ResourceReference[Fhir::Observation]] # Resource(Observation)
  end

  # Should be present
  attribute :recommendation, Array[Recommendation] # 
end

