# Represents a defined collection of entities that may be
# discussed or acted upon collectively but which are not
# expected to act collectively and are not formally or legally
# recognized.  I.e. A collection of entities that isn't an
# Organization.
class Fhir::Group < Fhir::Resource
  # Additional Content defined by implementations
  attribute :extensions, Array[Fhir::Extension] # Extension

  # Text summary of the resource, for human interpretation
  attribute :text, Fhir::Narrative # Narrative

  # Contained, inline Resources
  attribute :containeds, Array[Fhir::Resource] # Resource

  # Unique id
  attribute :identifier, Fhir::Identifier # Identifier

  # Group Classification
  # Should be present
  attribute :type, Fhir::Code # code

  # Descriptive or actual
  # Should be present
  attribute :actual, Boolean # boolean

  # Kind of Group members
  attribute :code, Fhir::CodeableConcept # CodeableConcept

  # Label for Group
  attribute :name, String # string

  # Number of members
  attribute :quantity, Integer # integer

  # Identifies the traits shared by members of the group.
  class Characteristic < Fhir::ValueObject
    # Kind of characteristic
    # Should be present
    attribute :type, Fhir::CodeableConcept # CodeableConcept

    # Value held by characteristic
    # Should be present
    attribute :value, Fhir::CodeableConcept # CodeableConcept

    # Group includes or excludes
    # Should be present
    attribute :exclude, Boolean # boolean
  end

  attribute :characteristics, Array[Characteristic] # 

  # Who is in group
  attribute :members, Array[Fhir::ResourceReference[Fhir::Patient, Fhir::Practitioner, Fhir::Device, Fhir::Medication]] # Resource(Patient|Practitioner|Device|Medication)
end

