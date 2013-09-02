require 'spec_helper'

describe 'AllergyIntolerance' do
  example do
    allergy = Fhir::AllergyIntolerance.new(
      criticality: 'fatal',
      sensitivity_type: 'allergy',
      recorded_date: Time.now,
      status: 'status',
      substance: {
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

    p allergy
    allergy.criticality.should == 'fatal'
    allergy.sensitivity_type.should == 'allergy'
    p allergy.recorded_date
    allergy.status.should == 'status'
    allergy.substance.type.codings.first.system.should == 'RxNorm'
    p allergy.reactions
  end
end
