require 'spec_helper'

describe 'Fhir::CodeableConcept' do
  class TestModel < Fhir::Resource
    attribute :color, Fhir::CodeableConcept
  end


  it 'should search coding by attributes' do
    model = TestModel.new(
      color: {
        codings: [{
          system: 'RGB',
          code: 'FF0000',
          display: 'red'
        }, {
          system: 'RGBA',
          code: 'FF000000',
          display: 'red'
        }]
      }
    )
    rgb_color = model.color.with_system('RGB')
    rgb_color.system.should == 'RGB'
    rgb_color.code.should == 'FF0000'
    rgb_color.display.should == 'red'

    rgba_color = model.color.with_system('RGBA')
    rgba_color.system.should == 'RGBA'
    rgba_color.code.should == 'FF000000'
    rgba_color.display.should == 'red'
  end

  it 'should return coding on shortcut methods if codings number equal 1' do
    model = TestModel.new(
      color: {
        codings: [{
          system: 'RGB',
          code: 'FF0000',
          display: 'red'
        }]
      }
    )
    model.color.primary.system.should == 'RGB'
    model.color.primary.code.should == 'FF0000'
    model.color.primary.display.should == 'red'
  end
end
