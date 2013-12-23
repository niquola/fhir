require 'spec_helper'

describe 'Fhir::Coding' do
  it 'should create coding by system_oid' do
    coding = Fhir::Coding.new(system: :rgb)
    coding.system.should == "urn:oid:RGB"
  end

  it 'should create coding by system' do
    coding = Fhir::Coding.new(system: 'ups')
    coding.system.should == "ups"
  end

  it 'test equality' do
    Fhir::Coding.new(system: 'ups').should == Fhir::Coding.new(system: 'ups')
  end

  it "#to_concept should convert to CodableConcept" do
    coding = Fhir::Coding.new(system: 'ups', code: 'ups', display: 'display')
    concept = coding.to_concept
    concept.should_not be_nil
    concept.should be_a(Fhir::CodeableConcept)
    concept.text.should == coding.display
    concept.coding.first.should == coding
  end
end
