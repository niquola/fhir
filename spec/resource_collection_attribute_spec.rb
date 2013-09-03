require 'spec_helper'

describe 'ResourceAttribute' do
  class Res1 < Fhir::Resource
    attribute :prop1, String
  end

  class Res2 < Fhir::Resource
    attribute :prop2, String
  end

  class TestRes1 < Fhir::Resource
    resource_references :subjects, Res1
  end

  class TestRes2 < Fhir::Resource
    resource_references :subjects, [Res1, Res2]
  end

  it "hash in constructor"  do
    res = TestRes1.new(subjects: [
      { resource_type: 'Res1', prop1: 'val1' },
      { resource_type: 'Res1', prop1: 'val2' }
    ])

    res.subjects.size == 2
    subj = res.subjects.first
    subj.should be_a(Res1)
    subj.prop1.should == 'val1'
    subj = res.subjects.last
    subj.prop1.should == 'val2'
    subj.should be_a(Res1)

    res.subject_refs.size == 2
  end

  it "hash in constructor"  do
    res = TestRes2.new(subjects: [
      { resource_type: 'Res1', prop1: 'val1' },
      { resource_type: 'Res2', prop2: 'val2' },
      Res1.new(prop1: 'val3')
    ])

    res.subjects.size == 2

    subj = res.subjects.first
    subj.should be_a(Res1)
    subj.prop1.should == 'val1'

    subj = res.subjects.second
    subj.prop2.should == 'val2'
    subj.should be_a(Res2)

    subj = res.subjects.last
    subj.should be_a(Res1)
    subj.prop1.should == 'val3'

    res.subject_refs.size == 3
  end
end
