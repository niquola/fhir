require 'nokogiri'
require 'active_support/core_ext'

FHIR_DIR = "#{File.dirname(__FILE__)}/.."

def xml(path) #profile doc
  doc = Nokogiri::XML(open(path).read)
  doc.remove_namespaces!
end

def valuesets(base_path)
  Dir["#{base_path}/meta/valueset-*.xml"]
end

def value_by_path(node, path, attr = :value)
  (node.xpath("./#{path}").first || {})[attr]
end


def comment_text(line)
  line.split("\n").map{|l| "# #{l}"}.join("\n") + "\n"
end

dir = File.dirname(__FILE__) + "/valuesets"
FileUtils.rm_rf(dir)
FileUtils.mkdir_p(dir)

valuesets(FHIR_DIR).each do |f|
  x = xml(f)
  vs = x.xpath('//ValueSet')
  hname = value_by_path(vs, 'name') #.to_s + ' ' +  value_by_path(vs, 'identifier').to_s
  next if hname.nil?
  name = hname.gsub(/(\.|\/|\s|\[|\]|\(|\))/,'_').underscore
  name = name.gsub(/_+/,'_')
  name = "#{name}_value_set"



  open("#{dir}/#{name}.rb", 'w') do |out|
    out << comment_text(value_by_path(vs, 'description'))
    out << comment_text(vs.to_s)
    out<< "class Fhir::#{name.camelize} < Fhir::ValueSet\n"
    vs.xpath('./compose/include').each do |inc|
      out<< "#  #{value_by_path(inc, 'system')}\n"
      inc.xpath('./code').each do |c|
        out<< "#     #{c}\n"
      end
    end
    out<< "end\n"
  end
end
