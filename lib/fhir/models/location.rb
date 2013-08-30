# Contact details and position information for a physical
# place that may be visited and where healthcare resources and
# participants may be found or contained, accommodated, or
# stored.
class Fhir::Location < Fhir::Resource
  # Additional Content defined by implementations
  attribute :extension, Array[Fhir::Extension] # Extension

  # Text summary of the resource, for human interpretation
  attribute :text, Fhir::Narrative # Narrative

  # Contained, inline Resources
  attribute :contained, Array[Fhir::Resource] # Resource

  # Name of the location
  # Should be present
  attribute :name, String # string

  # Description of the Location
  attribute :description, String # string

  # Classification of the location
  attribute :type, Array[Fhir::CodeableConcept] # CodeableConcept

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
  attribute :provider, Fhir::ResourceReference[Fhir::Organization] # Resource(Organization)

  # Whether the location is still used to provide services
  attribute :active, Boolean # boolean

  # Another Location which this Location is physically inside
  # of
  attribute :part_of, Fhir::ResourceReference[Fhir::Location] # Resource(Location)
end

