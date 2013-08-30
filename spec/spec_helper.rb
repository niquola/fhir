require 'virtus'

RSpec.configure do |config|
  config.before(:all) do
    require "#{File.dirname(__FILE__)}/../generation/generate.rb"

    require 'fhir'
  end
end
