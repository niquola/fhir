require 'open-uri'
require 'fileutils'

FHIR_URI = 'http://www.hl7.org/implement/standards/fhir/profiles-resources.xml'

FHIR_FILE = "#{File.dirname(__FILE__)}/meta/resources.xml"

unless File.exists?(FHIR_FILE)
  FileUtils.mkdir_p(File.dirname(FHIR_FILE))
  File.open(FHIR_FILE, 'w') do |cf|
    cf << open(FHIR_URI).readlines.join("\n")
  end
end
