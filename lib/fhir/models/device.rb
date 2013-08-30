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
  attribute :extension, Array[Fhir::Extension] # Extension

  # Text summary of the resource, for human interpretation
  attribute :text, Fhir::Narrative # Narrative

  # Contained, inline Resources
  attribute :contained, Array[Fhir::Resource] # Resource

  # What kind of device this is
  # Should be present
  attribute :type, Fhir::CodeableConcept # CodeableConcept

  # Name of device manufacturer
  attribute :manufacturer, String # string

  # Model id assigned by the manufacturer
  attribute :model, String # string

  # Version number (i.e. software)
  attribute :version, String # string

  # Date of expiry of this device (if applicable)
  attribute :expiry, Date # date

  # Universal Device Id fields.
  class Identity < Fhir::ValueObject
    # Global Trade Identification Number
    attribute :gtin, String # string

    # Lot number of manufacture
    attribute :lot, String # string

    # Serial number assigned by the manufacturer
    # Should be present
    attribute :serial_number, String # string
  end

  attribute :identity, Identity # 

  # Organization responsible for device
  attribute :owner, Fhir::ResourceReference[Fhir::Organization] # Resource(Organization)

  # Identifier assigned by various organizations
  attribute :assigned_id, Array[Fhir::Identifier] # Identifier

  # Where the resource is found
  attribute :location, Fhir::ResourceReference[Fhir::Location] # Resource(Location)

  # If the resource is affixed to a person
  attribute :patient, Fhir::ResourceReference[Fhir::Patient] # Resource(Patient)

  # Details for human/organization for support
  attribute :contact, Array[Fhir::Contact] # Contact

  # Network address to contact device
  attribute :url, Fhir::URI # uri
end

