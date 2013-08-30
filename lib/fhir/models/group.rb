# Represents a defined collection of entities that may be
# discussed or acted upon collectively but which are not
# expected to act collectively and are not formally or legally
# recognized.  I.e. A collection of entities that isn't an
# Organization.
class Fhir::Group < Fhir::Resource
  # Additional Content defined by implementations
  attribute :extension, Array[Extension]

  # Text summary of the resource, for human interpretation
  attribute :text, Narrative

  # Contained, inline Resources
  attribute :contained, Array[ResourceLink[Resource]]

  # Unique id
  attribute :identifier, Identifier

  # Group Classification
  # Should be present
  attribute :type, code

  # Descriptive or actual
  # Should be present
  attribute :actual, boolean

  # Kind of Group members
  attribute :code, CodeableConcept

  # Label for Group
  attribute :name, string

  # Number of members
  attribute :quantity, integer

  # Identifies the traits shared by members of the group.
  class Characteristic < Fhir::ValueObject
    # Kind of characteristic
    # Should be present
    attribute :type, CodeableConcept

    # Value held by characteristic
    # Should be present
    attribute :value[x], CodeableConcept

    # Group includes or excludes
    # Should be present
    attribute :exclude, boolean
  end

  attribute :characteristic, Array[Characteristic]

  # Who is in group
  attribute :member, Array[ResourceLink[Patient, Practitioner, Device, Medication]]
end

