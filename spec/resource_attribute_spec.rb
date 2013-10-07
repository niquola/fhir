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
    resource_reference :any_resource, Fhir::Resource
  end

  class TestRes2 < Fhir::Resource
    resource_reference :subject, [Res1, Res2]
  end

  it "hash in constructor"  do
    res = TestRes1.new(subject: {
                         _type: 'Res1',
                         prop1: 'val1'
                       })

    res.subject.is_a?(Res1)
    res.subject.prop1.should == 'val1'
    res.subject_ref.should_not be_nil
    res.subject_ref.type.should == 'Res1'
    res.subject_ref.reference.should_not be_nil
    res.subject_ref.reference.should == res.subject.uri
  end

  it "should allow to set any resource if reference is declared with base Resource class" do
    res = TestRes1.new(any_resource: {
                         _type: 'Res1',
                         prop1: "some value"
                       })
    res.any_resource_ref.reference.should == res.any_resource.uri
  end

  it "wrong object in constructor" do
    pending
    ->  {
      TestRes1.new(subject: Object.new)
    }.should raise_error /Unexpected value/
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
    res.subject_ref.reference.should == res.subject.uri
  end

  it "polymorphic resource ref" do
    res = TestRes2.new(subject: {
      _type: 'Res1',
      prop1: 'val1'})

    res.subject.is_a?(Res1)
    res.subject.prop1.should == 'val1'
    res.subject_ref.should_not be_nil
    res.subject_ref.type.should == 'Res1'
    res.subject_ref.reference.should_not be_nil
    res.subject_ref.reference.should == res.subject.uri
  end

  it "polymorphic resource ref" do
    res = TestRes2.new(
      subject: {
	_type: 'Res2',
	prop2: 'val2'
      }
    )

    res.subject.is_a?(Res2)
    res.subject.prop2.should == 'val2'
    res.subject_ref.should_not be_nil
    res.subject_ref.type.should == 'Res2'
    res.subject_ref.reference.should_not be_nil
    res.subject_ref.reference.should == res.subject.uri
  end
end
