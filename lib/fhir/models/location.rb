# Contact details and position information for a physical
# place that may be visited and where healthcare resources and
# participants may be found or contained, accommodated, or
# stored.
class Fhir::Location < Fhir::Resource
  # Name of the location
  # Should be present
  attribute :name, String # string

  # Description of the Location
  attribute :description, String # string

  # Classification of the location
  attribute :types, Array[Fhir::CodeableConcept] # CodeableConcept

  # Contact details of the location
  attribute :telecom, Fhir::Contact # Contact

  # Physical location
  attribute :address, Fhir::Address # Address

  # The absolute geographic location of the Location,
  # expressed in a KML compatible manner (see notes below for
  # KML).
  class Position < Fhir::ValueObject
    # Longitude
    # Should be present
    attribute :longitude, Float # decimal

    # Latitude
    # Should be present
    attribute :latitude, Float # decimal

    # Altitude
    attribute :altitude, Float # decimal
  end

  attribute :position, Position # 

  # The organization that provides services at the location
  resource_reference :provider, [Fhir::Organization]

  # Whether the location is still used to provide services
  attribute :active, Boolean # boolean

  # Another Location which this Location is physically inside
  # of
  resource_reference :part_of, [Fhir::Location]
end

