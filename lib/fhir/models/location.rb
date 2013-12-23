# Details and position information for a physical place
# where services are provided  and resources and participants
# may be stored, found, contained or accommodated.
class Fhir::Location < Fhir::Resource
  # Extensions that cannot be ignored
  attribute :modifier_extension, Array[Fhir::Extension]

  # Text summary of the resource, for human interpretation
  attribute :text, Fhir::Narrative

  # Unique code or number identifying the location to its
  # users
  attribute :identifier, Fhir::Identifier

  # Name of the location as used by humans
  attribute :name, String

  # Description of the Location, which helps in finding or
  # referencing the place
  attribute :description, String

  # Indicates the type of function performed at the location
  attribute :type, Fhir::CodeableConcept

  # Contact details of the location
  attribute :telecom, Fhir::Contact

  # Physical location
  attribute :address, Fhir::Address

  # Physical form of the location
  attribute :physical_type, Fhir::CodeableConcept

  # The absolute geographic location of the Location,
  # expressed in a KML compatible manner (see notes below for
  # KML).
  class Position < Fhir::ValueObject
    invariants do
      validates_presence_of :longitude
      validates_presence_of :latitude
    end

    # Extensions that cannot be ignored
    attribute :modifier_extension, Array[Fhir::Extension]

    # Longitude as expressed in KML
    attribute :longitude, Float

    # Latitude as expressed in KML
    attribute :latitude, Float

    # Altitude as expressed in KML
    attribute :altitude, Float
  end

  attribute :position, Position

  # The organization that is responsible for the provisioning
  # and upkeep of the location
  resource_reference :managing_organization, [Fhir::Organization]

  # active | suspended | inactive
  attribute :status, Fhir::Code

  # Another Location which this Location is physically part of
  resource_reference :part_of, [Fhir::Location]

  # instance | kind
  attribute :mode, Fhir::Code
end


Fhir.load_extension('location')
