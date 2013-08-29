# An instance of a manufactured thing that is used in the provision of healthcare
class Device
  include Virtus
  # Additional Content defined by implementations
  attribute :extension, Extension

  # Text summary of the resource, for human interpretation
  attribute :text, Narrative

  # Contained, inline Resources
  attribute :contained, Resource

  # What kind of device this is
  attribute :type, CodeableConcept

  # Name of device manufacturer
  attribute :manufacturer, String

  # Model id assigned by the manufacturer
  attribute :model, String

  # Version number (i.e. software)
  attribute :version, String

  # Date of expiry of this device (if applicable)
  attribute :expiry, date

  # Universal Device Id fields
  attribute :identity, Identity

  class Identity
    include Virtus::ValueObject
    # Global Trade Identification Number
    attribute :gtin, String

    # Lot number of manufacture
    attribute :lot, String

    # Serial number assigned by the manufacturer
    attribute :serialNumber, String

  end
  # Organization responsible for device
  attribute :owner, Resource(Organization)

  # Identifier assigned by various organizations
  attribute :assignedId, Identifier

  # Where the resource is found
  attribute :location, Resource(Location)

  # If the resource is affixed to a person
  attribute :patient, Resource(Patient)

  # Details for human/organization for support
  attribute :contact, Contact

  # Network address to contact device
  attribute :url, uri

end
