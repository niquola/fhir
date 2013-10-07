require 'spec_helper'

describe "Observation full stack example" do
  let(:observation_atts) {
    {
      uuid: "f4aa62b0-c662-4285-b9fe-67c1def6391d",
      name:
      {
        codings: [
          {
            system: "http://snomed.info/id",
            code: "387458008",
            display: "X-ray",
            _type: "Fhir::Coding"
          }
        ],
        text: "X-ray",
        _type: "Fhir::CodeableConcept"
      },
      value: {
        value: 65.0,
        comparator: nil,
        units: "mm[Hg]",
        system: nil,
        code: nil,
        _type: "Fhir::Quantity"
      },
      interpretation: {
        codings: [
          {
            system: "http://hl7.org/fhir/vs/observation-interpretation",
            code: "L",
            display: "Below low normal",
            _type: "Fhir::Coding"
          }
        ],
        text: "Below low normal",
        _type: "Fhir::CodeableConcept"
      },
      comments: "Comment",
      applies: DateTime.now,
      issued: 5.days.ago,
      status: {
        system: "http://hl7.org/fhir/observation-status",
        code: "final",
        display:
        "The observation is complete and verified by an authorised person",
        _type: "Fhir::Coding"
      },
      reliability: {
        system: "http://hl7.org/fhir/vs/observation-reliability",
        code: "ok",
        display: "The result has no reliability concerns.",
        _type: "Fhir::Coding"
      },
      identifier: {
        use: nil,
        label: nil,
        system: "medapp_observations",
        key: "02186030-1179-0131-fe0e-1c6f65c378d6",
        period: nil,
        assigner: nil,
        assigner_ref: nil,
        _type: "Fhir::Identifier"
      },
      subject_ref: {
        type: "Fhir::Patient",
        reference: "fhir/patients/c7e91a23-ece6-42cf-a7af-aabc96dc407c",
        display: nil,
        _type: "Fhir::ResourceReference"
      }
    }
  }

  let(:observation) { Fhir::Observation.new(observation_atts) }

  it "should corrrectly coerce 'applies' attribute" do
    observation.applies.should_not be_nil
  end
end
