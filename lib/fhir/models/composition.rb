# A set of healthcare-related information that is assembled
# together into a single logical document that provides a
# single coherent statement of meaning, establishes its own
# context and that has clinical attestation with regard to who
# is making the statement.
class Fhir::Composition < Fhir::Resource
  invariants do
    validates_presence_of :instant
    validates_presence_of :type
    validates_presence_of :status
    validates_presence_of :confidentiality
    validates_presence_of :subject_ref
    validates_presence_of :author_ref
  end

  # Extensions that cannot be ignored
  attribute :modifier_extension, Array[Fhir::Extension]

  # Text summary of the resource, for human interpretation
  attribute :text, Fhir::Narrative

  # Logical identifier of composition (version-independent)
  attribute :identifier, Fhir::Identifier

  # Composition editing time
  attribute :instant, DateTime

  # Kind of composition (LOINC if possible)
  attribute :type, Fhir::CodeableConcept

  # Categorisation of Composition
  attribute :composition_class, Fhir::CodeableConcept

  # Human Readable name/title
  attribute :title, String

  # preliminary | final | appended | amended | entered in
  # error
  attribute :status, Fhir::Code

  # As defined by affinity domain
  attribute :confidentiality, Fhir::Coding

  # Who/what the composition is about
  resource_reference :subject, [Fhir::Patient, Fhir::Practitioner, Fhir::Group, Fhir::Device, Fhir::Location]

  # Who/what authored the composition
  resource_references :author, [Fhir::Practitioner, Fhir::Device, Fhir::Patient, Fhir::RelatedPerson]

  # A participant who has attested to the accuracy of the
  # composition/document.
  class Attester < Fhir::ValueObject
    invariants do
      validates_presence_of :mode
    end

    # Extensions that cannot be ignored
    attribute :modifier_extension, Array[Fhir::Extension]

    # personal | professional | legal | official
    attribute :mode, Array[Fhir::Code]

    # When composition attested
    attribute :time, DateTime

    # Who attested the composition
    resource_reference :party, [Fhir::Patient, Fhir::Practitioner, Fhir::Organization]
  end

  attribute :attester, Array[Attester]

  # Org which maintains the composition
  resource_reference :custodian, [Fhir::Organization]

  # The main event/act/item, such as a colonoscopy or an
  # appendectomy, being documented.
  class Event < Fhir::ValueObject
    # Extensions that cannot be ignored
    attribute :modifier_extension, Array[Fhir::Extension]

    # Code(s) that apply to the event being documented
    attribute :code, Array[Fhir::CodeableConcept]

    # The period covered by the documentation
    attribute :period, Fhir::Period

    # Full details for the event(s) the composition concents
    resource_references :detail, [Fhir::Resource]
  end

  attribute :event, Event

  # Context of the conposition
  resource_reference :encounter, [Fhir::Encounter]

  # The root of the sections that make up the composition.
  class Section < Fhir::ValueObject
    # Extensions that cannot be ignored
    attribute :modifier_extension, Array[Fhir::Extension]

    # Classification of section (recommended)
    attribute :code, Fhir::CodeableConcept

    # If section different to composition
    resource_reference :subject, [Fhir::Patient, Fhir::Group, Fhir::Device]

    # The actual data for the section
    resource_reference :content, [Fhir::Resource]

    # Nested Section
    attribute :section, Array[Fhir::Composition::Section]
  end

  attribute :section, Array[Section]
end


Fhir.load_extension('composition')
