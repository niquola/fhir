require 'spec_helper'
require 'active_model'

describe "Validation" do

  class Code < Fhir::Type
    attribute :code, String
    attribute :system, String

    with_options :if => ->(obj) { obj.active_validators.include?(:invariant) } do
      validates_presence_of :code
      validates_length_of :code, minimum: 1
    end
  end

  class Substance < Fhir::Type
    attribute :codings, Array[Code]
  end

  class Allergy < Fhir::Resource
    with_options :if => ->(obj) { obj.active_validators.include?(:invariant) } do
      validates_presence_of :substance
    end

    attribute :substance, *Fhir::Type[Substance]
  end

  example do
    allergy = Allergy.new(substance: {
                            _type: "Substance",
                            codings: [
                              {
                                code: "123541",
                                system: "FDB"
                              }
                            ]
                          })

    -> { allergy.substance = nil }.should raise_error(/Invalid value/)
  end

  example do
    hash_to_validate = {
      substance: {
        _type: "Substance",
        codings: [
          {
            code: "",
            system: "FDB"
          }
        ]
      }
    }

    errors = Allergy.validate_attributes(hash_to_validate)
    p errors.to_yaml
  end
end
