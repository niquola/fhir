require 'spec_helper'

describe Fhir::Condition do
  it 'should report true when active' do
   attrs = {
      subject_ref: {
        _type: "Fhir::ResourceReference",
        type: 'Patient',
        reference: '3123123'
      },
      date_asserted: Date.today,
      asserter: {
        _type: 'Fhir::Practitioner',
        name: {
          text: 'Roman',
          families: ['Abramovich', 'Yanukovich'],
          givens: ['Albert', 'Eduard']
        }
      },
      code: {
        text: 'Asthma',
        codings: [ {
          system: 'http://snomed.info/id',
          code: '195967001',
          display: 'Asthma'
        }]
      },
      category: {
        text: 'Complaint',
        codings: [ {
          system: 'http://snomed.info/id',
          code: '409586006',
          display: 'Complaint'
        }]
      },
      status: 'working',
      certainty: {
        text: 'code text'
      },
      severity: {
        text: 'code text'
      },
      onset: Date.today,
      abatement: Date.today,
      stage: {
        summary: {
          text: 'code text'
        }
      },
      notes: 'notes',
      evidences: [{
        code: {
          text: 'code text'
        }
      }],
      locations: [{
        detail: 'detail',
        code: {
          text: 'code text'
        }
      }],
      related_items: [{
        type: 'follows',
        code: {
          text: 'code text'
        }
      }]
    }
    condition = Fhir::Condition.new(attrs)
    condition.should be_active
    condition.status = 'refuted'
    condition.should be_inactive
  end
end
