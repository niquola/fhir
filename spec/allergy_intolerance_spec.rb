require 'spec_helper'

describe 'AllergyIntolerance' do
  example do
    allergy = Fhir::AllergyIntolerance.new(
      criticality: 'fatal',
      sensitivity_type: 'allergy',
      recorded_date: Time.now,
      status: 'status',
      substance: {
        _type: "Fhir::Substance",
        name: 'substance name',
        type: {
          text: 'aspirin',
          codings: [
            {
              system: 'RxNorm',
              code: '123456',
              display: 'aspirin'
            }
          ]
        },
        description: 'substance description',
        status: { text: 'active' },
        effective_time: {
          start: Time.now,
          end: Time.now
        }
      },
      reactions: [{
        _type: "Fhir::AdverseReaction",
        reaction_date: Time.now,
        did_not_occur_flag: false,
        symptoms: [{
          code: {text: 'pain'},
          severity: 'over 9000'
        }],
        exposures: [{
          exposure_date: Time.now,
          exposure_type: 'exposure type',
          causality_expectation: 'expectation code',
        }]
      }]
    )

    allergy.criticality.should == 'fatal'
    allergy.sensitivity_type.should == 'allergy'
    allergy.status.should == 'status'
    allergy.substance.type.codings.first.system.should == 'RxNorm'
  end
end
