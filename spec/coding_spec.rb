require 'spec_helper'

describe 'Fhir::Coding' do
  example do
    coding = Fhir::Coding.new(system_oid: 'ups')
    coding.system.should_not be_nil
    p coding
  end
end
