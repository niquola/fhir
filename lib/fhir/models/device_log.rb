class DeviceLog
  attribute :extension, Extension
  attribute :text, Narrative
  attribute :contained, Resource
  attribute :instant, instant
  attribute :capabilities, Resource(DeviceCapabilities)
  attribute :subject, Resource(Patient|Group|Device)
  attribute :item, Item
  class Item
    attribute :key, String
    attribute :value, String
    attribute :flag, code
  end
end
