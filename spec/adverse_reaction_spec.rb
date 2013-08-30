require 'spec_helper'

describe Fhir::AdverseReaction do
  it "should allow to set attrs via hash" do
    ar = subject.new(text: "Itching",
                     reaction_date: Time.now,
                     symptom: {
                       severity: "moderate"
                     })

    ar.text.should == "Itching"
    ar.symptom.severity.should == "moderate"
  end
end
