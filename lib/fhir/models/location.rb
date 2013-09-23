# Contact details and position information for a physical
# place that may be visited and where healthcare resources and
# participants may be found or contained, accommodated, or
# stored.
class Fhir::Location < Fhir::Resource
  invariants do
    validates_presence_of :name
  end

  # Text summary of the resource, for human interpretation
  attribute :text, Fhir::Narrative

  # Name of the location
  attribute :name, String

  # Description of the Location
  attribute :description, String

  # Classification of the location
  attribute :types, Array[Fhir::CodeableConcept]

  # Contact details of the location
  attribute :telecom, Fhir::Contact

  # Physical location
  attribute :address, Fhir::Address

  # The absolute geographic location of the Location,
  # expressed in a KML compatible manner (see notes below for
  # KML).
  class Position < Fhir::ValueObject
    invariants do
      validates_presence_of :longitude
      validates_presence_of :latitude
    end

    # Longitude
    attribute :longitude, Float

    # Latitude
    attribute :latitude, Float

    # Altitude
    attribute :altitude, Float
  end

  attribute :position, Position

  # The organization that provides services at the location
  resource_reference :provider, [Fhir::Organization]

  # Whether the location is still used to provide services
  attribute :active, Boolean

  # Another Location which this Location is physically inside
  # of
  resource_reference :part_of, [Fhir::Location]
end


Fhir.load_extension('location')
