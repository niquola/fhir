require 'spec_helper'

describe 'Fhir::Coding' do
  it 'should create coding by system_oid' do
    coding = Fhir::Coding.new(system_oid: 'ups')
    coding.system.should == "urn:oid:ups"
  end

  it 'should create coding by system' do
    coding = Fhir::Coding.new(system: 'ups')
    coding.system.should == "ups"
  end
end
