require 'spec_helper'
require 'json'

EXAMPLE_JSONS = Dir[File.dirname(__FILE__) + "/../meta/*example.json"].delete_if { |f| f.include?("other") }

describe "Fhir Example JSON Data" do
  def fix_json(json)
    if json.is_a?(Array)
      json.map do |element|
        fix_json(element)
      end
    elsif json.is_a?(Hash)
      if json.keys == ["value"]
        json["value"]
      else
        fixed_json = {}

        json.each do |key, value|
          fixed_key = key.underscore
          fixed_json[fixed_key] = fix_json(value)
        end

        fixed_json
      end
    else
      json
    end
  end

  EXAMPLE_JSONS.each do |file_name|
    json = JSON.parse(File.read(file_name))
    resource_name = json.keys.first
    data = json.values.first

    it "should load example data for #{resource_name} resource from file #{file_name}" do
      if resource_name == "AdverseReaction" && false
        puts fix_json(data).to_yaml
        puts '-' * 40
      end

      resource_class = "Fhir::#{resource_name}".constantize
      fixed_json = fix_json(data)

      begin
        res = resource_class.new(fixed_json)
      rescue => e
        puts "Loading data into #{resource_name}: #{e.message}"
        puts fixed_json.to_yaml
        raise e
      end
    end
  end
end
