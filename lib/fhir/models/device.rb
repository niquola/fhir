# This resource identifies an instance of a manufactured
# thing that is used in the provision of healthcare without
# being substantially changed through that activity. The
# device may be a machine, an insert, a computer, an
# application, etc. This includes durable (reusable) medical
# equipment as well as disposable equipment used for
# diagnostic, treatment, and research for healthcare and
# public health.
class Fhir::Device < Fhir::Resource
  # Additional Content defined by implementations
  attribute :extension, Array[Extension]

  # Text summary of the resource, for human interpretation
  attribute :text, Narrative

  # Contained, inline Resources
  attribute :contained, Array[ResourceLink[Resource]]

  # What kind of device this is
  # Should be present
  attribute :type, CodeableConcept

  # Name of device manufacturer
  attribute :manufacturer, string

  # Model id assigned by the manufacturer
  attribute :model, string

  # Version number (i.e. software)
  attribute :version, string

  # Date of expiry of this device (if applicable)
  attribute :expiry, date

  # Universal Device Id fields.
  class Identity < Fhir::ValueObject
    # Global Trade Identification Number
    attribute :gtin, string

    # Lot number of manufacture
    attribute :lot, string

    # Serial number assigned by the manufacturer
    # Should be present
    attribute :serial_number, string
  end

  attribute :identity, Identity

  # Organization responsible for device
  attribute :owner, ResourceLink[Organization]

  # Identifier assigned by various organizations
  attribute :assigned_id, Array[Identifier]

  # Where the resource is found
  attribute :location, ResourceLink[Location]

  # If the resource is affixed to a person
  attribute :patient, ResourceLink[Patient]

  # Details for human/organization for support
  attribute :contact, Array[Contact]

  # Network address to contact device
  attribute :url, uri
end

