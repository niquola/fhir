require 'virtus'
require 'fhir'
require 'active_support/core_ext'

RSpec.configure do |config|
  config.before(:all) do
    require "#{File.dirname(__FILE__)}/../generation/generate.rb"
  end
end
