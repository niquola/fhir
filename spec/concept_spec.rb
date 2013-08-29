require 'spec_helper'

class Fhir::Identifier

  include Virtus::ValueObject
  attribute :use, String, meta: 'meta'
  attribute :label, String
  attribute :system, String
  attribute :key, String
end

describe 'concept' do
  example do
    id = Fhir::Identifier.new(use: 'common',
			   key: '323123',
			   label: 'f asfsd',
			   system: 'MedClient')
    p Fhir::Identifier.attribute_set.to_a
    p id.attributes
  end
  # example do
  #   attrs = {
  #     identifier: [
	# {
	  # use: 'usual',
	  # label: '007',
	  # system: 'my-hospital.com',
	  # key: '007'
	# }
  #     ],
  #     patient: {
	# type: 'Patient',
	# reference: '12321',
	# display: 'Abram Ivanov'
  #     },
  #     medication: {
	# name: 'aspirin',
	# code: {
	  # text: 'aspirin',
	  # primary: 'rxnorm',
	  # coding: [
	    # {
	      # system: 'rxnorm',
	      # code: '321312',
	      # display: 'Aspirin 30mg'
	    # }
	  # ]
	# }
  #     }
  #   }
  #   ms = Fhir::MedicationStatement.new(attrs)
  #   ms.to_attributes.should == attrs
  # end


end
