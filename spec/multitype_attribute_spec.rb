require 'spec_helper'

describe 'ResourceAttribute' do

  class Type1 < Fhir::Type
    attribute :prop1, String
  end

  class Type2 < Fhir::Type
    attribute :prop2, String
  end

  class TestRes < Fhir::Resource
    attribute :prop, *Fhir::Type[Type1, Type2, Integer]
  end

  it "hash in constructor"  do
    res = TestRes.new(prop: {
                         _type: 'Type2',
                         prop2: 'val2'
                       })

    res.prop.should be_a(Type2)
    res.prop.prop2.should == 'val2'
  end

  it "simple type"  do
    res = TestRes.new(prop: 1)

    res.prop.should be_a(Integer)
    res.prop.should == 1
  end
end
