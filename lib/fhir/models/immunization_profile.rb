# A patient's point-of-time immunization status and
# recommendation with optional supporting justification.
class Fhir::ImmunizationProfile < Fhir::Resource
  invariants do
    validates_presence_of :subject_ref
    validates_presence_of :recommendations
  end

  # Text summary of the resource, for human interpretation
  attribute :text, Fhir::Narrative

  # Who this profile is for
  resource_reference :subject, [Fhir::Patient]

  # Vaccine administration recommendations.
  class Recommendation < Fhir::ValueObject
    invariants do
      validates_presence_of :recommendation_date
      validates_presence_of :vaccine_type
      validates_presence_of :forecast_status
    end

    # Recommendation date
    attribute :recommendation_date, DateTime

    # Vaccine that pertains to the recommendation
    attribute :vaccine_type, Fhir::CodeableConcept

    # Recommended dose number
    attribute :dose_number, Integer

    # Vaccine administration status
    attribute :forecast_status, Fhir::Code

    # Vaccine date recommentations - e.g. earliest date to
    # administer, latest date to administer, etc.
    class DateCriterion < Fhir::ValueObject
      invariants do
        validates_presence_of :code
        validates_presence_of :value
      end

      # Date classification of recommendation
      attribute :code, Fhir::CodeableConcept

      # Date recommendation
      attribute :value, DateTime
    end

    attribute :date_criterions, Array[DateCriterion]

    # Contains information about the protocol under which the
    # vaccine was administered.
    class Protocol < Fhir::ValueObject
      # Dose Number
      attribute :dose_sequence, Integer

      # Vaccine Administration Protocol Description
      attribute :description, String

      # Vaccine Administration Protocol Authority
      resource_reference :authority, [Fhir::Organization]

      # Vaccine Series
      attribute :series, String
    end

    attribute :protocol, Protocol

    # Supporting Immunization
    resource_references :supporting_immunizations, [Fhir::Immunization]

    # Adverse event report information that supports the status
    # and recommendation.
    class SupportingAdverseEventReport < Fhir::ValueObject
      invariants do
        validates_presence_of :identifiers
      end

      # Adverse event report identifier
      attribute :identifiers, Array[String]

      # Adverse event report classification
      attribute :report_type, Fhir::CodeableConcept

      # Adverse event report date
      attribute :report_date, DateTime

      # Adverse event report text
      attribute :text, String

      # Documented reaction
      resource_references :reactions, [Fhir::AdverseReaction]
    end

    attribute :supporting_adverse_event_reports, Array[SupportingAdverseEventReport]

    # Supporting Patient Observation
    resource_references :supporting_patient_observations, [Fhir::Observation]
  end

  attribute :recommendations, Array[Recommendation]
end


Fhir.load_handmade('models/immunization_profile')
