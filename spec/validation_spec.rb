require 'spec_helper'
describe "Validation" do

  # aggregate
  #   key: value
  #   key: value_object
  #   key: collection [ value_object ]

  # validations
  # * presence
  # * inclusion
  # * custom

  module Invariants
    module ClassMethods
      class Invariant
	def initialize(name, proprs)
	  @name, @proprs = name , proprs
	end
      end

      def invarialts
	@invarialts ||= []
      end

      def invariant(attr_name, proprs)
	self.invarialts<< Invariant.new(attr_name, proprs)
      end
    end
  end

  class Allergy
    include Virtus
    include Invariants
    extend Invariants::ClassMethods

    attribute :name, String
    invariant :name, presence: true
  end

  example do
    Allergy.new({}) #=> should raise exception

    a = Allergy.new(name: 'bla bla')
  end
end
