class Fhir::Condition
  ACTIVE_STATUSES = %w(provisional working confirmed)

  def active?
    ACTIVE_STATUSES.include?(status)
  end

  def inactive?
    not active?
  end
end
