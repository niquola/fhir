class Fhir::URI < String
  def uuid
    components.last.gsub("@", '')
  end

  def type
    components.first
  end

  def to_s
    String.new(self)
  end

  private

  def components
    self.split("/")
  end
end
