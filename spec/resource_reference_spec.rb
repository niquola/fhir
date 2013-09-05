require 'spec_helper'

describe "Resource References: inline and external" do
  it "should allow to inline resources" do
    patient = Fhir::Patient.new(names: [{ givens: ["Alexey", "Pivovarov"] }])
    patient.independent!

    substance = Fhir::Substance.new(name: "cats")
    substance.should be_contained
    substance.should_not be_independent

    allergy = Fhir::AllergyIntolerance.new(substance: substance,
                                           subject: patient)

    allergy.subject_ref.should_not be_nil
    allergy.subject.should_not be_contained

    allergy.substance = substance
    allergy.substance.should be_contained

    serialized = allergy.serialize
    serialized[:subject].should be_nil
    serialized[:substance].should_not be_nil
  end
end
