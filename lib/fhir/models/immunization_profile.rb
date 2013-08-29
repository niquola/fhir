class ImmunizationProfile
  include Virtus
  # Additional Content defined by implementations
  attribute :extension, Extension

  # Text summary of the resource, for human interpretation
  attribute :text, Narrative

  # Contained, inline Resources
  attribute :contained, Resource

  # Who this profile is for
  attribute :subject, Resource(Patient)

  # Vaccine administration recommendations
  attribute :recommendation, Recommendation

  class Recommendation
    include Virtus::ValueObject
    # Recommendation date
    attribute :recommendationDate, DateTime

    # Vaccine that pertains to the recommendation
    attribute :vaccineType, CodeableConcept

    # Recommended dose number
    attribute :doseNumber, integer

    # Vaccine administration status
    attribute :forecastStatus, code

    # Pertinent dates
    attribute :dateCriterion, DateCriterion

    class DateCriterion
      include Virtus::ValueObject
      # Date classification of recommendation
      attribute :code, CodeableConcept

      # Date recommendation
      attribute :value, DateTime

    end
    # Vaccine Administration Protocol
    attribute :protocol, Protocol

    class Protocol
      include Virtus::ValueObject
      # Dose Number
      attribute :doseSequence, integer

      # Vaccine Administration Protocol Description
      attribute :description, String

      # Vaccine Administration Protocol Authority
      attribute :authority, Resource(Organization)

      # Vaccine Series
      attribute :series, String

    end
    # Supporting Immunization
    attribute :supportingImmunization, Resource(Immunization)

    # Supporting adverse event report
    attribute :supportingAdverseEventReport, SupportingAdverseEventReport

    class SupportingAdverseEventReport
      include Virtus::ValueObject
      # Adverse event report identifier
      attribute :identifier, id

      # Adverse event report classification
      attribute :reportType, CodeableConcept

      # Adverse event report date
      attribute :reportDate, DateTime

      # Adverse event report text
      attribute :text, String

      # Documented reaction
      attribute :reaction, Resource(AdverseReaction)

    end
    # Supporting Patient Observation
    attribute :supportingPatientObservation, Resource(Observation)

  end
end
