require 'cogi_phony/version'
require 'yaml'

module CogiPhony
  def self.hi
    puts "Hello from Cogi::Phony"
  end

  def self.country_codes_hash
    @country_codes_hash ||= YAML.load_file(File.join(File.dirname(File.expand_path(__FILE__)), 'data/country_codes.yaml'))
  end
end
