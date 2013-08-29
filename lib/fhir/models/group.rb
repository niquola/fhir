class Group
  attribute :extension, Extension
  attribute :text, Narrative
  attribute :contained, Resource
  attribute :identifier, Identifier
  attribute :type, code
  attribute :actual, boolean
  attribute :code, CodeableConcept
  attribute :name, String
  attribute :quantity, integer
  attribute :characteristic, Characteristic
  class Characteristic
    attribute :type, CodeableConcept
    attribute :value[x], CodeableConcept
    attribute :exclude, boolean
  end
  attribute :member, Resource(Patient|Practitioner|Device|Medication)
end
