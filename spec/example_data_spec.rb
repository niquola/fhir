require 'spec_helper'
require 'json'

EXAMPLE_JSONS = Dir[File.dirname(__FILE__) + "/../meta/*example.json"].delete_if { |f| f.include?("other") }

describe "Fhir Example JSON Data" do
  def is_reference(value)
    ref = value.is_a?(Array) ? value.first : value
    ref.is_a?(::Hash) && (ref.keys - ["type", "reference", "display"]).empty?
  end

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
          is_collection = value.is_a?(::Array)

          if is_reference(value)
            fixed_json["#{fixed_key}_ref#{is_collection ? "s" : ""}"] = fix_json(value)
          else
            fixed_key = fixed_key.pluralize if is_collection
            fixed_json[fixed_key] = fix_json(value)
          end
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
      if resource_name == "Alert" && false
        puts fix_json(data).to_yaml
        puts '-' * 40
      end

      resource_class = "Fhir::#{resource_name}".constantize
      fixed_json = fix_json(data)


      res = resource_class.new(fixed_json)
    end
  end
end
