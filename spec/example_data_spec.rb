require 'spec_helper'
require 'json'
EXAMPLE_JSONS = Dir[File.dirname(__FILE__) + "/../meta/*example.json"].delete_if { |f| f.include?("other") }

class Fhir::JsonFactory
  class << self
    def from_json(json_text)
      from_fhir_hash JSON.parse(json_text)
    end

    def from_fhir_hash(hash)
      type, hash =  hash.first
      res = transform_value(hash.dup, type)
      res[:_type] = "Fhir::#{type}"
      res.delete(:containeds)
      res
    end

    X_ATTRS = /_(date|resource_ref|boolean|schedule|string|date_time|quantity)$/

    def transform_key(key, value)
      k = key.to_s.underscore
      if ['expiration_date','birth_date', 'recommendation_date','dose_quantity', 'exposure_date', 'reaction_date', 'recorded_date'].include?(k)
        return k
      end
      return "encounter_class".to_sym if "class" == k
      k =  k.gsub(X_ATTRS,'')
      is_collection = value.is_a?(::Array)
      if is_reference(value, key)
        k = "#{k.singularize}_ref#{is_collection ? 's' : ''}"
        k =  k.gsub(X_ATTRS,'')
      elsif is_collection
        k = k.pluralize
      end
      k.to_sym
    end

    def transform_value(value, key)
      case value
      when Array
        value.map {|i| transform_value(i, key) }
      when Hash
        transform_hash(value, key)
      else
        value
      end
    end

    def transform_hash(json, key)
      if json.keys == ["value"]
        return json["value"]
      end

      {}.tap do |fixed_json|
        json.each do |k, value|
          fixed_key = transform_key(k, value).to_sym
          fixed_json[fixed_key] = transform_value(value, k)
        end

        g = X_ATTRS.match(key.underscore)
        if type = (g && g[1])
          fixed_json[:_type] = "Fhir::#{type.camelize}"
        end
        fixed_json.delete(:_id)
      end
    end

    def is_reference(value, key)
      return false if ['substitution'].include?(key)
      ref = value.is_a?(Array) ? value.first : value
      ref.is_a?(::Hash) && (ref.keys - ["type", "reference", "display"]).empty?
    end
  end
end

# describe "Fhir::JsonFactory" do
#   [
#     [{"Observation" => { name: 'bp' }}, {_type: 'Observation', name: 'bp'}],
#   ].each do  |ex, res|
#     it "should work" do
#       Fhir::JsonFactory.from_fhir_hash(ex).should == res
#     end
#   end
# end



describe "Fhir Example JSON Data" do
  pending

  # EXAMPLE_JSONS.each do |file_name|
  #   next if file_name.ends_with?("xds-example.json")

  #   data = Fhir::JsonFactory.from_json(File.read(file_name))
  #   resource_name = data[:_type]

  #   it "should load example data for #{resource_name} resource from file #{file_name}" do
  #     # next unless resource_name == 'Fhir::Group'
  #     if resource_name == "Alert" && false
  #       puts fix_json(data).to_yaml
  #       puts '-' * 40
  #     end

  #     resource_class = resource_name.constantize
  #     obs =  resource_class.new(data)
  #   end
  # end
end
