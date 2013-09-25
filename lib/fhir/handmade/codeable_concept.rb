# A concept that may be defined by a formal reference to a
# terminology or ontology or may be provided by text.
class Fhir::CodeableConcept < Fhir::DataType
  # Code defined by a terminology system
  attribute :codings, Array[Fhir::Coding]

  # Plain text representation of the concept
  attribute :text, String

  # Which code was chosen directly by the user
  #attribute :primary, Integer

  def with_system(system)
    only(system).first
  end

  def primary
    codings.first
  end

  # Find codings only for specified code systems. Example:
  # concept.only(:rxnorm, :unii)
  def only(*systems)
    systems.map do |s|
      found_system = Fhir::CodeSystem.find(s)
      codings.select { |c| c.get_system == found_system } if found_system.present?
    end.compact.flatten
  end

  # Inverse of #only() method
  def except(*systems)
    found_systems = systems.map { |s| Fhir::CodeSystem.find(s) }

    codings.select { |c| !found_systems.include?(c.get_system) }
  end
end

