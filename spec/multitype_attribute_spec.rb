require 'spec_helper'

describe 'Fhir::Virtus::Coercer' do
  class Quantity
    include Virtus::ValueObject

    attribute :value, Float
    attribute :units, String
  end

  class Coding
    include Virtus::ValueObject

    attribute :code, String
    attribute :system, String
  end

  class SomeType
    include Virtus::ValueObject
    attribute :value, String
  end

  class Observation
    include Virtus
    attribute :name, String
    attribute :value,  *Fhir::Type[Float, Quantity, Coding]
    attribute :values, *Fhir::Collection[Float, Quantity, Coding]
  end

  it "hash in constructor"  do
    obs = Observation.new(name: "BP",
                          value: {
                            _type: "Quantity",
                            value: 120,
                            units: "hgmm"
                          })

    obs.value.should be_instance_of(Quantity)
    obs.value.value.should == 120
    obs.value.units.should == 'hgmm'
  end

  it "should do type checking"  do
    lambda do
      Observation.new(name: "BP",
                      value: {
                        _type: "SomeType",
                        value: 120
                      })
    end.should raise_error(/type/)
  end

  it "should preserve primitive types"  do
    Observation.new(name: "BP",
                    value: "120").value.should == 120.0

    Observation.new(name: "BP",
                    value: "120.4").value.should == 120.4
  end

  it "should support multitype arrays" do
    obs = Observation.new(name: "example",
                          values: [
                            12,
                            { _type: "Quantity", value: 30, units: "bpm" },
                            { _type: "Coding", code: "34521", system: "loinc" }
                          ])

    obs.values.first.should == 12

    obs.values.second.class.should == Quantity
    obs.values.second.value.should == 30

    obs.values.third.class.should == Coding
    obs.values.third.code.should == "34521"
  end
end
