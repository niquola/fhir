require 'spec_helper'
require 'active_model'

describe "Validation" do

  class Code < Fhir::Type
    attribute :code, String
    attribute :system, String

    invariants do
      validates_presence_of :code
      validates_length_of :code, minimum: 1
    end
  end

  class Substance < Fhir::Type
    attribute :codings, *Fhir::Collection[Code]
  end

  class Allergy < Fhir::Type
    invariants do
      validates_presence_of :substance
    end

    attribute :substance, *Fhir::Type[Substance]
  end

  it "should create with valid attrs" do
    allergy = Allergy.new(substance: {
                               _type: "Substance",
                               codings: [
                                 {
                                   _type: "Code",
                                   code: "123541",
                                   system: "FDB"
                                 }
                               ]
                             })

    allergy.should be_instance_of(Allergy)

    -> { allergy.substance = nil }
    .should raise_error(/Invalid value/)
  end

  it "should raise on new" do
    -> { Allergy.create(substance: nil) }
    .should raise_error(/Invalid value/)
  end

  example do
    hash_to_validate = {
      substance: {
        _type: "Substance",
        codings: [
          {
            _type: "Code",
            code: "",
            system: "FDB"
          }
        ]
      }
    }
    hash_with_errors = Allergy.validate_attributes(hash_to_validate)
    hash_with_errors[:substance][:codings].first[:_errors][:code].should_not be_empty
  end
end
