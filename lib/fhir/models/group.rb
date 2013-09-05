# Represents a defined collection of entities that may be
# discussed or acted upon collectively but which are not
# expected to act collectively and are not formally or legally
# recognized.  I.e. A collection of entities that isn't an
# Organization.
class Fhir::Group < Fhir::Resource
  invariants do
    validates_presence_of :type
    validates_presence_of :actual
  end

  # Unique id
  attribute :identifier, Fhir::Identifier

  # Group Classification
  # Should be present
  attribute :type, Fhir::Code

  # Descriptive or actual
  # Should be present
  attribute :actual, Boolean

  # Kind of Group members
  attribute :code, Fhir::CodeableConcept

  # Label for Group
  attribute :name, String

  # Number of members
  attribute :quantity, Integer

  # Identifies the traits shared by members of the group.
  class Characteristic < Fhir::ValueObject
    invariants do
      validates_presence_of :type
      validates_presence_of :value
      validates_presence_of :exclude
    end

    # Kind of characteristic
    # Should be present
    attribute :type, Fhir::CodeableConcept

    # Value held by characteristic
    # Should be present
    attribute :value, *Fhir::Type[Fhir::CodeableConcept, String, Boolean, Fhir::Quantity, Fhir::Range]

    # Group includes or excludes
    # Should be present
    attribute :exclude, Boolean
  end

  attribute :characteristics, Array[Characteristic]

  # Who is in group
  resource_references :members, [Fhir::Patient, Fhir::Practitioner, Fhir::Device, Fhir::Medication]
end

