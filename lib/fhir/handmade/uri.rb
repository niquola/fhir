class Fhir::URI < String
  def uuid
    components.last
  end

  def type
    components.first
  end

  private

  def components
    self.split("/")
  end
end
