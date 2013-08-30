# A patient's point-of-time immunization status and
# recommendation with optional supporting justification.
class Fhir::ImmunizationProfile < Fhir::Resource
  # Additional Content defined by implementations
  attribute :extension, Array[Extension]

  # Text summary of the resource, for human interpretation
  attribute :text, Narrative

  # Contained, inline Resources
  attribute :contained, Array[ResourceLink[Resource]]

  # Who this profile is for
  # Should be present
  attribute :subject, ResourceLink[Patient]

  # Vaccine administration recommendations.
  class Recommendation < Fhir::ValueObject
    # Recommendation date
    # Should be present
    attribute :recommendation_date, dateTime

    # Vaccine that pertains to the recommendation
    # Should be present
    attribute :vaccine_type, CodeableConcept

    # Recommended dose number
    attribute :dose_number, integer

    # Vaccine administration status
    # Should be present
    attribute :forecast_status, code

    # Vaccine date recommentations - e.g. earliest date to
    # administer, latest date to administer, etc.
    class DateCriterion < Fhir::ValueObject
      # Date classification of recommendation
      # Should be present
      attribute :code, CodeableConcept

      # Date recommendation
      # Should be present
      attribute :value, dateTime
    end

    attribute :date_criterion, Array[DateCriterion]

    # Contains information about the protocol under which the
    # vaccine was administered.
    class Protocol < Fhir::ValueObject
      # Dose Number
      attribute :dose_sequence, integer

      # Vaccine Administration Protocol Description
      attribute :description, string

      # Vaccine Administration Protocol Authority
      attribute :authority, ResourceLink[Organization]

      # Vaccine Series
      attribute :series, string
    end

    attribute :protocol, Protocol

    # Supporting Immunization
    attribute :supporting_immunization, Array[ResourceLink[Immunization]]

    # Adverse event report information that supports the status
    # and recommendation.
    class SupportingAdverseEventReport < Fhir::ValueObject
      # Adverse event report identifier
      # Should be present
      attribute :identifier, Array[id]

      # Adverse event report classification
      attribute :report_type, CodeableConcept

      # Adverse event report date
      attribute :report_date, dateTime

      # Adverse event report text
      attribute :text, string

      # Documented reaction
      attribute :reaction, Array[ResourceLink[AdverseReaction]]
    end

    attribute :supporting_adverse_event_report, Array[SupportingAdverseEventReport]

    # Supporting Patient Observation
    attribute :supporting_patient_observation, Array[ResourceLink[Observation]]
  end

  # Should be present
  attribute :recommendation, Array[Recommendation]
end

