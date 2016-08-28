require 'cogi_phony/version'
require 'yaml'

module CogiPhony
  def self.hi
    puts "Hello from Cogi::Phony"
  end

  def self.country_codes_hash
    @country_codes_hash ||= YAML.load_file(File.join(File.dirname(File.expand_path(__FILE__)), 'data/country_codes.yaml'))
  end

  def self.mobile_networks_hash
    @mobile_networks_hash ||= YAML.load_file(File.join(File.dirname(File.expand_path(__FILE__)), 'data/mobile_networks.yaml'))
  end

  def self.gmobile?(phone)
    pattern = /\A(\+84|84|0)(#{mobile_networks_hash['vi']['gmobile']})\d{7}$/
    pattern.match phone
  end

  def self.vietnamobile?(phone)
    pattern = /\A(\+84|84|0)(#{mobile_networks_hash['vi']['vietnamobile']})\d{7}$/
    pattern.match phone
  end

  def self.mobifone?(phone)
    pattern = /\A(\+84|84|0)(#{mobile_networks_hash['vi']['mobifone']})\d{7}$/
    pattern.match phone
  end

  def self.vinaphone?(phone)
    pattern = /\A(\+84|84|0)(#{mobile_networks_hash['vi']['vinaphone']})\d{7}$/
    pattern.match phone
  end

  def self.viettel?(phone)
    pattern = /\A(\+84|84|0)(#{mobile_networks_hash['vi']['viettel']})\d{7}$/
    pattern.match phone
  end

  def self.phone_to_provider(phone)
    return 'Viettel' if self.viettel? phone
    return 'Mobifone' if self.mobifone? phone
    return 'Vinaphone' if self.vinaphone? phone
    return 'Vietnamobile' if self.vietnamobile? phone
    return 'Gmobile (Beeline)' if self.gmobile? phone
    'Others'
  end
end
