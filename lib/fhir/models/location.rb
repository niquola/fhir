# Contact details and position information for a physical
# place that may be visited and where healthcare resources and
# participants may be found or contained, accommodated, or
# stored.
class Fhir::Location < Fhir::Resource
  # Additional Content defined by implementations
  attribute :extension, Array[Extension]

  # Text summary of the resource, for human interpretation
  attribute :text, Narrative

  # Contained, inline Resources
  attribute :contained, Array[ResourceLink[Resource]]

  # Name of the location
  # Should be present
  attribute :name, string

  # Description of the Location
  attribute :description, string

  # Classification of the location
  attribute :type, Array[CodeableConcept]

  # Contact details of the location
  attribute :telecom, Contact

  # Physical location
  attribute :address, Address

  # The absolute geographic location of the Location,
  # expressed in a KML compatible manner (see notes below for
  # KML).
  class Position < Fhir::ValueObject
    # Longitude
    # Should be present
    attribute :longitude, decimal

    # Latitude
    # Should be present
    attribute :latitude, decimal

    # Altitude
    attribute :altitude, decimal
  end

  attribute :position, Position

  # The organization that provides services at the location
  attribute :provider, ResourceLink[Organization]

  # Whether the location is still used to provide services
  attribute :active, boolean

  # Another Location which this Location is physically inside
  # of
  attribute :part_of, ResourceLink[Location]
end

