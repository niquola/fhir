module Fhir
  @config = {}

  def self.config
    @config
  end

  def self.configure(config)
    @config = config
  end
end
