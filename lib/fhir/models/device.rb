class Device
  attribute :extension, Extension
  attribute :text, Narrative
  attribute :contained, Resource
  attribute :type, CodeableConcept
  attribute :manufacturer, String
  attribute :model, String
  attribute :version, String
  attribute :expiry, date
  attribute :identity, Identity
  class Identity
    attribute :gtin, String
    attribute :lot, String
    attribute :serialNumber, String
  end
  attribute :owner, Resource(Organization)
  attribute :assignedId, Identifier
  attribute :location, Resource(Location)
  attribute :patient, Resource(Patient)
  attribute :contact, Contact
  attribute :url, uri
end
