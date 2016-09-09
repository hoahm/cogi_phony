require 'cogi_phony/error'
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

  # Return a Hash of mobile networks
  #
  #
  # @return [Hash]
  def self.mobile_networks_hash
    @mobile_networks_hash ||= YAML.load_file(File.join(File.dirname(File.expand_path(__FILE__)), 'data/mobile_networks.yaml'))
  end

  # Check if a phone number is provided by Gmobile
  #
  # @param [String] phone Phone number
  #
  # @return [Boolean]
  def self.gmobile?(phone)
    pattern = /\A(\+84|084|84|0)(#{mobile_networks_hash['vi']['gmobile']})\d{7}$/
    pattern.match phone
  end

  # Check if a phone number is provided by Vietnamobile
  #
  # @param [String] phone Phone number
  #
  # @return [Boolean]
  def self.vietnamobile?(phone)
    pattern = /\A(\+84|084|84|0)(#{mobile_networks_hash['vi']['vietnamobile']})\d{7}$/
    pattern.match phone
  end

  # Check if a phone number is provided by Mobifone
  #
  # @param [String] phone Phone number
  #
  # @return [Boolean]
  def self.mobifone?(phone)
    pattern = /\A(\+84|084|84|0)(#{mobile_networks_hash['vi']['mobifone']})\d{7}$/
    pattern.match phone
  end

  # Check if a phone number is provided by Vinaphone
  #
  # @param [String] phone Phone number
  #
  # @return [Boolean]
  def self.vinaphone?(phone)
    pattern = /\A(\+84|084|84|0)(#{mobile_networks_hash['vi']['vinaphone']})\d{7}$/
    pattern.match phone
  end

  # Check if a phone number is provided by Viettel
  #
  # @param [String] phone Phone number
  #
  # @return [Boolean]
  def self.viettel?(phone)
    pattern = /\A(\+84|084|84|0)(#{mobile_networks_hash['vi']['viettel']})\d{7}$/
    pattern.match phone
  end

  # Return phone provider from phone number.
  #
  # @param [String] phone Phone number
  #
  # @return [String] Phone provider
  #
  # @example
  #   CogiPhony.phone_to_provider('0988091097') # => Viettel
  #   CogiPhony.phone_to_provider('0938091097') # => Mobifone
  #   CogiPhony.phone_to_provider('0918091097') # => Vinaphone
  #   CogiPhony.phone_to_provider('0928091097') # => Vietnamobile
  #   CogiPhony.phone_to_provider('0998091097') # => Gmobile (Beeline)
  #   CogiPhony.phone_to_provider('0837621351') # => Others
  def self.phone_to_provider(phone)
    return 'Viettel' if self.viettel? phone
    return 'Mobifone' if self.mobifone? phone
    return 'Vinaphone' if self.vinaphone? phone
    return 'Vietnamobile' if self.vietnamobile? phone
    return 'Gmobile (Beeline)' if self.gmobile? phone
    'Others'
  end

  # Check if phone number is Vietnam mobile phone format
  #
  # A phone is valid if:
  #   - Is not empty
  #   - Begin with +84|84|0 and
  #     - next number is 8|9 the length must be 8 (short number. Ex: 0933081090)
  #     - next number is 1, the length must be 9 (long number: Ex: 01214468866)
  #
  # @param [String] phone Phone number
  #
  # @return [Boolean] True if it is in Vietnam mobile phone format, otherwise False
  #
  # @example
  #   CogiPhony.vn_mobile_phone?('0933081090')     # => true
  #   CogiPhony.vn_mobile_phone?('84933081090')    # => true
  #   CogiPhony.vn_mobile_phone?('+84933081090')   # => true
  #   CogiPhony.vn_mobile_phone?('+14037089189')   # => false
  #   CogiPhony.vn_mobile_phone?('84837621350')    # => false
  def self.vn_mobile_phone?(phone)
    return false if phone.nil? || phone.empty?
    return false if /\A(\+84|084|84|0)((9\d{8})|(88\d{7})|(1\d{9}))$/.match(phone).nil?
    true
  end

  # Check if a phone number is in Vietnam
  #
  # @param [String] phone Phone number
  #
  # @return [Boolean] True if phone in vietnam, otherwise False
  #
  # @example
  #   CogiPhony.vn_phone?('+84933081090') # => True
  #   CogiPhony.vn_phone?('084933081090') # => True
  #   CogiPhony.vn_phone?('84933081090')  # => True
  #   CogiPhony.vn_phone?('0933081090')   # => True
  #   CogiPhony.vn_phone?('+14037089189') # => False
  def self.vn_phone?(phone)
    return false unless /\A(\+84|84|084|0)(\d{8}|\d{9})$/.match phone
    true
  end

  # Format formats phone numbers according to the predominant format of a country.
  #
  # @param [String] phone Phone number
  # @param [Hash] options An option hash
  #   format: 'global' or 'vietnam'. Default is 'global'
  #
  # @return [String] Phone number formatted based on each country.
  #
  # @example
  #   CogiPhony.format('84933081090', format: 'global')   # => '+84 93 3081090'
  #   CogiPhony.format('84837621350', format: 'global')   # => '+84 8 3762 1350'
  #   CogiPhony.format('84933081090')                     # =>'+84 93 3081090'
  #   CogiPhony.format('14037089189')                     # => '+1 (403) 708-9189'
  #   CogiPhony.format('84933081090', format: 'vietnam')  # => '093 3081090'
  #   CogiPhony.format('84837621350', format: 'vietnam')  # => '08 3762 1350'
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
  # @param [String] phone Phone number
  #
  # @return [String] Phone number in national format
  #
  # @example
  #   CogiPhony.global_format('84933081090') # => '+84 93 3081090'
  #   CogiPhony.global_format('84837621350') # => '+84 8 3762 1350'
  #   CogiPhony.global_format('0933081090')  # => '0933081090'
  #   CogiPhony.global_format('14037089189') # => '+1 (403) 708-9189'
  #
  # @example It return raw number if can not format
  #   CogiPhony.national_format('+84837621350') # => '+84837621350'
  def self.global_format(phone)
    Phony.format(phone, format: :international) rescue phone
  end

  # Format phone number into national format.
  # If missing country code, it will return the raw number.
  #
  # @param [String] phone Phone number
  #
  # @return [String] Phone number in national format
  #
  # @example Format phone number into national format
  #   CogiPhony.national_format('84933081090') # => '093 3081090'
  #   CogiPhony.national_format('84837621350') # => '08 3762 1350'
  #
  # @example It return raw number if can not format
  #   CogiPhony.national_format('+84837621350') # => '+84837621350'
  def self.national_format(phone)
    Phony.format(phone, format: :national) rescue phone
  end

  # Extract country code from phone number.
  #
  # @param [String] phone Phone number
  #
  # @return [String] Country code
  # @return [nil] if can not extract country code
  #
  # @example
  #   CogiPhony.country_code_from_number('84933081090') # =>  '84'
  #   CogiPhony.country_code_from_number('0933081090')  # =>  nil
  def self.country_code_from_number(phone)
    return nil unless Phony.plausible?(phone)
    Phony.split(Phony.normalize(phone)).first
  end

  # Normalize phone numer to international format.
  #
  # @param [String] phone Phone number
  # @param [Hash] options An option hash
  #   format: 'global' or 'vietnam'. Default is 'global'
  #   default_country_code: Default country code
  #
  # @return [String] A phone number formatted in international format.
  #
  # @raise [CogiPhony::NormalizationError] If can not normalize the given number.
  #
  # @example Normalize phone number with country code.
  #   CogiPhony.normalize('+84 933081090 ')     # => '+84933081090'
  #   CogiPhony.normalize('(+84)933081090 ')    # => '+84933081090'
  #   CogiPhony.normalize('+8493-308-1090')     # => '+84933081090'
  #   CogiPhony.normalize('84 933081090 ')      # => '+84933081090'
  #   CogiPhony.normalize('+1 (403) 708-9189')  # => '+14037089189'
  #
  # @example Normalize phone number without country code, and in vietnam format
  #   CogiPhony.normalize('0933081090', format: 'vietnam') # => '+84933081090'
  #   CogiPhony.normalize('933081090', format: 'vietnam')  # => '+84933081090'
  #   CogiPhony.normalize('1214468866', format: 'vietnam') # => '+841214468866'
  #   CogiPhony.normalize('0837621351', format: 'vietnam') # => '+84837621351'
  #
  # @example Normalize phone number with default country code, and in global format
  #   CogiPhony.normalize('0933081090', default_country_code: '84')   # => '+84933081090'
  #   CogiPhony.normalize('933081090', default_country_code: '84')    # => '+84933081090'
  #   CogiPhony.normalize('(403) 708-9189', default_country_code: '1' # => '+14037089189'
  #
  # @example Normalize phone number with invalid default country code, and in global format
  #   CogiPhony.normalize('0933081090', default_country_code: '111111') # => raise error CogiPhony::NormalizationError
  #   CogiPhony.normalize('0933081090', default_country_code: 'abcd')   # => raise error CogiPhony::NormalizationError
  #
  # @example Normalize phone number without default country code, and in global format
  #   CogiPhony.normalize('0933081090', format: 'global') # => raise error CogiPhony::NormalizationError
  #   CogiPhony.normalize('37621351', format: 'global')   # => raise error CogiPhony::NormalizationError
  def self.normalize(phone, options = {})
    return nil if phone.nil?

    original_phone = phone.dup
    phone = phone.gsub(/\D/, '') # remove string character

    unless Phony.plausible?(phone) # Do not include country code
      if options[:format] == 'vietnam'
        phone = phone.gsub(/\A0(.*?)/, '84\1') # replace 0 with 84
        phone = "84#{phone}" if /\A(8|9)\d{8}$|\A1\d{9}$/.match phone # insert 84 before phone number
      else # if options[:format] == 'global'
        default_country_code = options[:default_country_code]
        if default_country_code && Phony.plausible?("#{default_country_code}#{phone.gsub(/^0/, '')}")
          phone = "#{default_country_code}#{phone.gsub(/^0/, '')}" # add country code before phone number
        else
          # TODO: handle if can not normalize
          raise CogiPhony::NormalizationError
        end
      end
    end

    phone = phone.gsub(/\A0(.*?)/, '\1') if phone.start_with?('084')
    phone = "+#{phone}" # add plus sign before phone number
    phone
  end

  # Check if a string is a valid phone number.
  # Reference: http://www.regexr.com/38pvb
  #
  # @param [String] phone Phone number
  #
  # @return [Boolean] True if it is in a valid phone number, otherwise False
  def self.validate?(phone)
    return false if phone.nil?

    # pattern = /\A((\+)?\d{1,6}|0)\d{7,10}$/
    pattern = /^\s*(?:\+?(\d{1,3}))?([-. (]*(\d{3})[-. )]*)?((\d{3})[-. ]*(\d{2,4})(?:[-.x ]*(\d+))?)\s*$/
    pattern.match phone
  end
end
