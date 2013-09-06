# Represents a defined collection of entities that may be
# discussed or acted upon collectively but which are not
# expected to act collectively and are not formally or legally
# recognized.  I.e. A collection of entities that isn't an
# Organization.
class Fhir::Group < Fhir::Resource
  invariants do
    validates_presence_of :type
    validates_inclusion_of :actual, in: [true, false]
  end

  # Text summary of the resource, for human interpretation
  attribute :text, Fhir::Narrative

  # Unique id
  attribute :identifier, Fhir::Identifier

  # Group Classification
  attribute :type, Fhir::Code

  # Descriptive or actual
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
      validates_inclusion_of :exclude, in: [true, false]
    end

    # Kind of characteristic
    attribute :type, Fhir::CodeableConcept

    # Value held by characteristic
    attribute :value, *Fhir::Type[Fhir::CodeableConcept, String, Boolean, Fhir::Quantity, Fhir::Range]

    # Group includes or excludes
    attribute :exclude, Boolean
  end

  attribute :characteristics, Array[Characteristic]

  # Who is in group
  resource_references :members, [Fhir::Patient, Fhir::Practitioner, Fhir::Device, Fhir::Medication]
end

