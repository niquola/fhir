require 'spec_helper'
require 'active_model'

describe "Validation" do

  class Code < Fhir::Type
    attribute :code, String
    attribute :system, String

    def initialize(*args)
      puts "Called Code#new with #{args.inspect}"
      super(*args)
    end

    invariants do
      validates_presence_of :code
      validates_length_of :code, minimum: 1
    end
  end

  class Substance < Fhir::Type
    attribute :codings, *Fhir::Collection[Code]
  end

  class Allergy < Fhir::Resource
    invariants do
      validates_presence_of :substance
    end

    def initialize(*args)
      puts "Called Allergy#new with #{args.inspect}"
      super(*args)
    end

    attribute :substance, *Fhir::Type[Substance]
  end

  example do
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

    -> { allergy.substance = nil }.should raise_error(/Invalid value/)
    -> { Allergy.new(allergy.serialize.except(:substance)) }.should raise_error(/Invalid value/)
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

    errors = Allergy.validate_attributes(hash_to_validate)
  end
end
