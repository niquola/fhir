# Contact details and position information for a physical place
class Location
  include Virtus
  # Additional Content defined by implementations
  attribute :extension, Extension

  # Text summary of the resource, for human interpretation
  attribute :text, Narrative

  # Contained, inline Resources
  attribute :contained, Resource

  # Name of the location
  attribute :name, String

  # Description of the Location
  attribute :description, String

  # Classification of the location
  attribute :type, CodeableConcept

  # Contact details of the location
  attribute :telecom, Contact

  # Physical location
  attribute :address, Address

  # The absolute geographic location
  attribute :position, Position

  class Position
    include Virtus::ValueObject
    # Longitude
    attribute :longitude, decimal

    # Latitude
    attribute :latitude, decimal

    # Altitude
    attribute :altitude, decimal

  end
  # The organization that provides services at the location
  attribute :provider, Resource(Organization)

  # Whether the location is still used to provide services
  attribute :active, boolean

  # Another Location which this Location is physically inside of
  attribute :partOf, Resource(Location)

end
