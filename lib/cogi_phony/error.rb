module CogiPhony
  class NormalizationError < StandardError
    def initialize
      super %Q{Can not normalize the given number. It is not a phone number.}
    end
  end
end
