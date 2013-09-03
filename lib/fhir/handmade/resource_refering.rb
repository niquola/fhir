module Fhir
  module ResourceRefering
    def resource_reference(name, types)
      attribute name, Fhir::Virtus::ResourceAttribute,
                types: Array(types)

      attribute "#{name}_ref", Fhir::ResourceReference
    end

    def resource_references(name, types)
      attribute name, Fhir::Virtus::ResourceCollectionAttribute,
                types: Array(types)

      attribute "#{name.to_s.singularize}_refs", Array[Fhir::ResourceReference]
    end
  end
end
