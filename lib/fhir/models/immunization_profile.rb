class ImmunizationProfile
  attribute :extension, Extension
  attribute :text, Narrative
  attribute :contained, Resource
  attribute :subject, Resource(Patient)
  attribute :recommendation, Recommendation
  class Recommendation
    attribute :recommendationDate, DateTime
    attribute :vaccineType, CodeableConcept
    attribute :doseNumber, integer
    attribute :forecastStatus, code
    attribute :dateCriterion, DateCriterion
    class DateCriterion
      attribute :code, CodeableConcept
      attribute :value, DateTime
    end
    attribute :protocol, Protocol
    class Protocol
      attribute :doseSequence, integer
      attribute :description, String
      attribute :authority, Resource(Organization)
      attribute :series, String
    end
    attribute :supportingImmunization, Resource(Immunization)
    attribute :supportingAdverseEventReport, SupportingAdverseEventReport
    class SupportingAdverseEventReport
      attribute :identifier, id
      attribute :reportType, CodeableConcept
      attribute :reportDate, DateTime
      attribute :text, String
      attribute :reaction, Resource(AdverseReaction)
    end
    attribute :supportingPatientObservation, Resource(Observation)
  end
end
