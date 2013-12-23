require 'spec_helper'

describe 'Fhir::CodeableConcept' do
  class TestModel < Fhir::Resource
    attribute :color, Fhir::CodeableConcept
  end

  let(:model) {
    TestModel.new(color: {
                    coding: [{
                        system: 'urn:oid:RGB',
                        code: 'FF0000',
                        display: 'red'
                      }, {
                        system: 'urn:oid:RGBA',
                        code: 'FF000000',
                        display: 'red'
                      }]
                  })
  }

  it 'should search coding by attributes' do
    rgb_color = model.color.with_system(:rgb)
    rgb_color.get_system.display.should == 'RGB'
    rgb_color.code.should == 'FF0000'
    rgb_color.display.should == 'red'

    rgba_color = model.color.with_system("urn:oid:RGBA")
    rgba_color.get_system.display.should == 'RGBA'
    rgba_color.code.should == 'FF000000'
    rgba_color.display.should == 'red'
  end

  it "should return code in code systems except specified" do
    codes = model.color.except(:rgb)
    codes.should be_present

    rgba_code = codes.first
    rgba_code.should_not be_nil
    rgba_code.get_system.should == Fhir::CodeSystem[:rgba]

    model.color.except(:rgb, :rgba).should be_empty
  end

  it "should return code in specified code systems" do
    codes = model.color.only(:rgb)
    codes.should be_present

    rgb_code = codes.first
    rgb_code.should_not be_nil
    rgb_code.get_system.should == Fhir::CodeSystem[:rgb]

    model.color.only(:rgb, :rgba)
      .map(&:get_system).should =~ [Fhir::CodeSystem[:rgb], Fhir::CodeSystem[:rgba]]
  end

  it 'should return coding on shortcut methods if codings number equal 1' do
    model.color.primary.get_system.should == Fhir::CodeSystem[:rgb]
    model.color.primary.code.should == 'FF0000'
    model.color.primary.display.should == 'red'
  end
end
