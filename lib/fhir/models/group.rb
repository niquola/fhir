class Group
  include Virtus
  # Additional Content defined by implementations
  attribute :extension, Extension

  # Text summary of the resource, for human interpretation
  attribute :text, Narrative

  # Contained, inline Resources
  attribute :contained, Resource

  # Unique id
  attribute :identifier, Identifier

  # Group Classification
  attribute :type, code

  # Descriptive or actual
  attribute :actual, boolean

  # Kind of Group members
  attribute :code, CodeableConcept

  # Label for Group
  attribute :name, String

  # Number of members
  attribute :quantity, integer

  # Trait of group members
  attribute :characteristic, Characteristic

  class Characteristic
    include Virtus::ValueObject
    # Kind of characteristic
    attribute :type, CodeableConcept

    # Value held by characteristic
    attribute :value[x], CodeableConcept

    # Group includes or excludes
    attribute :exclude, boolean

  end
  # Who is in group
  attribute :member, Resource(Patient|Practitioner|Device|Medication)

end
