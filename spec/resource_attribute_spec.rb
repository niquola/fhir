require 'spec_helper'

describe 'ResourceAttribute' do
  class Res1 < Fhir::Resource
    attribute :prop1, String
  end

  class Res2 < Fhir::Resource
    attribute :prop2, String
  end

  class TestRes1 < Fhir::Resource
    resource_reference :subject, Res1
  end

  class TestRes2 < Fhir::Resource
    resource_reference :subject, [Res1, Res2]
  end

  it "hash in constructor"  do
    res = TestRes1.new(
      subject: {
	resource_type: 'Res1',
	prop1: 'val1'
      }
    )

    res.subject.is_a?(Res1)
    res.subject.prop1.should == 'val1'
    res.subject_ref.should_not be_nil
    res.subject_ref.type.should == 'Res1'
    res.subject_ref.reference.should_not be_nil
    res.subject_ref.reference.should == res.subject.uuid
  end

  it "wrong object in constructor" do
    ->  {
      TestRes1.new(subject: Object.new)
    }.should raise_error /Unexpected type/
  end

  it "object in constructor" do
    res = TestRes1.new(subject: Res1.new( prop1: 'val1'))
    res.subject.is_a?(Res1)
    res.subject.prop1.should == 'val1'
  end

  it "inline resource ref in constructor"  do
    res = TestRes1.new({})
    res.subject = Res1.new( prop1: 'val1' )

    res.subject.is_a?(Res1)
    res.subject.prop1.should == 'val1'
    res.subject_ref.should_not be_nil
    res.subject_ref.type.should == 'Res1'
    res.subject_ref.reference.should_not be_nil
    res.subject_ref.reference.should == res.subject.uuid
  end

  it "polymorphic resource ref" do
    res = TestRes2.new(subject: {
      resource_type: 'Res1',
      prop1: 'val1'})

    res.subject.is_a?(Res1)
    res.subject.prop1.should == 'val1'
    res.subject_ref.should_not be_nil
    res.subject_ref.type.should == 'Res1'
    res.subject_ref.reference.should_not be_nil
    res.subject_ref.reference.should == res.subject.uuid
  end

  it "polymorphic resource ref" do
    res = TestRes2.new(
      subject: {
	resource_type: 'Res2',
	prop2: 'val2'
      }
    )

    res.subject.is_a?(Res2)
    res.subject.prop2.should == 'val2'
    res.subject_ref.should_not be_nil
    res.subject_ref.type.should == 'Res2'
    res.subject_ref.reference.should_not be_nil
    res.subject_ref.reference.should == res.subject.uuid
  end
end
