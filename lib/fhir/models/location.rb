class Location
  attribute :extension, Extension
  attribute :text, Narrative
  attribute :contained, Resource
  attribute :name, String
  attribute :description, String
  attribute :type, CodeableConcept
  attribute :telecom, Contact
  attribute :address, Address
  attribute :position, Position
  class Position
    attribute :longitude, decimal
    attribute :latitude, decimal
    attribute :altitude, decimal
  end
  attribute :provider, Resource(Organization)
  attribute :active, boolean
  attribute :partOf, Resource(Location)
end
