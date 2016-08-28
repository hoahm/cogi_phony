require 'spec_helper'

describe CogiPhony do
  subject { CogiPhony.new }

  describe '#hi' do
    it 'return nil' do
      expect(CogiPhony.hi).to eq(nil)
    end
  end
end
