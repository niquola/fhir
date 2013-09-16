class Fhir::Condition
  def active?
    %w(provisional working confirmed).include?(status)
  end

  def inactive?
    not active?
  end
end
