require 'spec_helper'

describe CogiPhony do
  subject { CogiPhony.new }

  describe '#hi' do
    it 'return nil' do
      expect(CogiPhony.hi).to eq(nil)
    end
  end

  describe '#country_codes_hash' do
    let(:country_codes) { CogiPhony.country_codes_hash }

    it 'return a hash' do
      expect(country_codes).to be_a(Hash)
    end

    it 'has countries key' do
      expect(country_codes['countries']).not_to be_nil
    end

    it 'return country code 84' do
      expect(country_codes['countries']['VN']['country_code']).to eq('84')
    end

    it 'return country name Vietnam' do
      expect(country_codes['countries']['VN']['name']).to eq('Viet Nam')
    end

    it 'return nil if invalid iso code' do
      expect(country_codes['countries']['ZZ']).to be_nil
    end
  end
end
