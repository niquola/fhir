require 'spec_helper'

describe "Datatypes" do
  example do
    address = Fhir::Address.new(
      uses: 'blah',
      texts: ['f safsad','f sadf sad'],
      line: 'Spb',
      cities: ['some city'],
    )
    p address
  end
end
