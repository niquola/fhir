require 'spec_helper'

describe "Fhir Ruby Impl syntax" do
  it "should be valid" do
    Dir[File.dirname(__FILE__) + "/../lib/**/*.rb"].each do |f|
      -> { require f }.should_not raise_error
    end
  end
end
