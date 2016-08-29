require 'cogi_phony/version'
require 'phony'
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

  # Check if phone number is Vietnam mobile phone format
  # A phone is valid if:
  #   - Is not empty
  #   - Begin with +84|84|0 and
  #     - next number is 8|9 the length must be 8 (short number. Ex: 0933081090)
  #     - next number is 1, the length must be 9 (long number: Ex: 01214468866)
  def self.vn_mobile_phone?(phone)
    return false if phone.nil? || phone.empty?
    return false if /\A(\+84|84|0)(((8|9)\d{8})|(1\d{9}))$/.match(phone).nil?
    true
  end

  # Format formats phone numbers according to the predominant format of a country.
  #
  # Params:
  #   format: global or vietnam. Default is global
  #
  # Example:
  #   CogiPhony.format('84933081090') ==> '+84 93 3081090'
  #   CogiPhony.format('84933081090', format: 'global') ==> '+84 93 3081090'
  #   CogiPhony.format('84837621350', format: 'global') ==> '+84 8 3762 1350'
  #   CogiPhony.format('84933081090', format: 'vietnam') ==> '093 3081090'
  #   CogiPhony.format('84837621350', format: 'vietnam') ==> '08 3762 1350'
  def self.format(phone, options = {})
    return nil if phone.nil?

    phone = phone.gsub(/\D/, '')
    format = options[:format] || 'global'
    formatted_phone = format == 'global' ? self.global_format(phone) : self.national_format(phone)
    formatted_phone
  end

  # Format phone number into international format.
  # If missing country code, it will return the raw number.
  #
  # Example:
  #   CogiPhony.global_format('84933081090') ==> '+84 93 3081090'
  #   CogiPhony.global_format('84837621350') ==> '+84 8 3762 1350'
  #   CogiPhony.global_format('0933081090')  ==> '0933081090'
  def self.global_format(phone)
    Phony.format(phone, format: :international) rescue phone
  end

  # Format phone number into national format.
  # If missing country code, it will return the raw number.
  #
  # Example:
  #   CogiPhony.national_format('84933081090') ==> '093 3081090'
  #   CogiPhony.national_format('84837621350') ==> '08 3762 1350'
  def self.national_format(phone)
    Phony.format(phone, format: :national) rescue phone
  end
end
