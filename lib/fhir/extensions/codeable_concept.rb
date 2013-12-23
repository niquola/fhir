class Fhir::CodeableConcept < Fhir::DataType
  def with_system(system)
    only(system).first
  end

  def primary
    coding.find(&:primary) || coding.first
  end

  # Find codings only for specified code systems. Example:
  # concept.only(:rxnorm, :unii)
  def only(*systems)
    systems.map do |s|
      found_system = Fhir::CodeSystem.find(s)
      coding.select { |c| c.get_system == found_system } if found_system.present?
    end.compact.flatten
  end

  # Inverse of #only() method
  def except(*systems)
    found_systems = systems.map { |s| Fhir::CodeSystem.find(s) }

    coding.select { |c| !found_systems.include?(c.get_system) }
  end
end
