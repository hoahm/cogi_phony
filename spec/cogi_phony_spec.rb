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

  describe '#mobile_networks' do
    let(:mobile_networks) { CogiPhony.mobile_networks_hash }

    it 'return a hash' do
      expect(mobile_networks).to be_a(Hash)
    end

    it 'return Viettel network' do
      expect(mobile_networks['vi']['viettel']).to be_a(String)
    end
  end

  describe '#gmobile?' do
    context 'mobile phone begin with 99' do
      it 'length equal 10 is valid' do
        expect(CogiPhony.gmobile?('0994567890')).not_to be_nil
        expect(CogiPhony.gmobile?('84994567890')).not_to be_nil
        expect(CogiPhony.gmobile?('+84994567890')).not_to be_nil
      end

      it 'length less than 10 is invalid' do
        expect(CogiPhony.gmobile?('099456789')).to be_nil
        expect(CogiPhony.gmobile?('8499456789')).to be_nil
        expect(CogiPhony.gmobile?('+8499456789')).to be_nil
      end

      it 'length more than 10 is invalid' do
        expect(CogiPhony.gmobile?('09945678901')).to be_nil
        expect(CogiPhony.gmobile?('849945678901')).to be_nil
        expect(CogiPhony.gmobile?('+849945678901')).to be_nil
      end
    end

    context 'mobile phone begin with 199' do
      it 'length equal 11 is valid' do
        expect(CogiPhony.gmobile?('01994567890')).not_to be_nil
        expect(CogiPhony.gmobile?('841994567890')).not_to be_nil
        expect(CogiPhony.gmobile?('+841994567890')).not_to be_nil
      end

      it 'length less than 11 is invalid' do
        expect(CogiPhony.gmobile?('0199456789')).to be_nil
        expect(CogiPhony.gmobile?('84199456789')).to be_nil
        expect(CogiPhony.gmobile?('+84199456789')).to be_nil
      end

      it 'length more than 11 is invalid' do
        expect(CogiPhony.gmobile?('019945678901')).to be_nil
        expect(CogiPhony.gmobile?('8419945678901')).to be_nil
        expect(CogiPhony.gmobile?('+8419945678901')).to be_nil
      end
    end
  end

  describe '#vietnamobile?' do
    context 'mobile phone begin with 92' do
      it 'length equal 10 is valid' do
        expect(CogiPhony.vietnamobile?('0924567890')).not_to be_nil
        expect(CogiPhony.vietnamobile?('84924567890')).not_to be_nil
        expect(CogiPhony.vietnamobile?('+84924567890')).not_to be_nil
      end

      it 'length less than 10 is invalid' do
        expect(CogiPhony.vietnamobile?('092456789')).to be_nil
        expect(CogiPhony.vietnamobile?('8492456789')).to be_nil
        expect(CogiPhony.vietnamobile?('+8492456789')).to be_nil
      end

      it 'length more than 10 is invalid' do
        expect(CogiPhony.vietnamobile?('09245678901')).to be_nil
        expect(CogiPhony.vietnamobile?('849245678901')).to be_nil
        expect(CogiPhony.vietnamobile?('+849245678901')).to be_nil
      end
    end

    context 'mobile phone begin with 186' do
      it 'length equal 11 is valid' do
        expect(CogiPhony.vietnamobile?('01864567890')).not_to be_nil
        expect(CogiPhony.vietnamobile?('841864567890')).not_to be_nil
        expect(CogiPhony.vietnamobile?('+841864567890')).not_to be_nil
      end

      it 'length less than 11 is invalid' do
        expect(CogiPhony.vietnamobile?('0186456789')).to be_nil
        expect(CogiPhony.vietnamobile?('84186456789')).to be_nil
        expect(CogiPhony.vietnamobile?('+84186456789')).to be_nil
      end

      it 'length more than 11 is invalid' do
        expect(CogiPhony.vietnamobile?('018645678901')).to be_nil
        expect(CogiPhony.vietnamobile?('8418645678901')).to be_nil
        expect(CogiPhony.vietnamobile?('+8418645678901')).to be_nil
      end
    end

    context 'mobile phone begin with 188' do
      it 'length equal 11 is valid' do
        expect(CogiPhony.vietnamobile?('01884567890')).not_to be_nil
        expect(CogiPhony.vietnamobile?('841884567890')).not_to be_nil
        expect(CogiPhony.vietnamobile?('+841884567890')).not_to be_nil
      end

      it 'length less than 11 is invalid' do
        expect(CogiPhony.vietnamobile?('0188456789')).to be_nil
        expect(CogiPhony.vietnamobile?('84188456789')).to be_nil
        expect(CogiPhony.vietnamobile?('+84188456789')).to be_nil
      end

      it 'length more than 11 is invalid' do
        expect(CogiPhony.vietnamobile?('018845678901')).to be_nil
        expect(CogiPhony.vietnamobile?('8418845678901')).to be_nil
        expect(CogiPhony.vietnamobile?('+8418845678901')).to be_nil
      end
    end
  end

  describe '#mobifone?' do
    context 'mobile phone begin with 90' do
      it 'length equal 10 is valid' do
        expect(CogiPhony.mobifone?('0904567890')).not_to be_nil
        expect(CogiPhony.mobifone?('84904567890')).not_to be_nil
        expect(CogiPhony.mobifone?('+84904567890')).not_to be_nil
      end

      it 'length less than 10 is invalid' do
        expect(CogiPhony.mobifone?('090456789')).to be_nil
        expect(CogiPhony.mobifone?('8490456789')).to be_nil
        expect(CogiPhony.mobifone?('+8490456789')).to be_nil
      end

      it 'length more than 10 is invalid' do
        expect(CogiPhony.mobifone?('09045678901')).to be_nil
        expect(CogiPhony.mobifone?('849045678901')).to be_nil
        expect(CogiPhony.mobifone?('+849045678901')).to be_nil
      end
    end

    context 'mobile phone begin with 121' do
      it 'length equal 11 is valid' do
        expect(CogiPhony.mobifone?('01214567890')).not_to be_nil
        expect(CogiPhony.mobifone?('841214567890')).not_to be_nil
        expect(CogiPhony.mobifone?('+841214567890')).not_to be_nil
      end

      it 'length less than 11 is invalid' do
        expect(CogiPhony.mobifone?('0121456789')).to be_nil
        expect(CogiPhony.mobifone?('84121456789')).to be_nil
        expect(CogiPhony.mobifone?('+84121456789')).to be_nil
      end

      it 'length more than 11 is invalid' do
        expect(CogiPhony.mobifone?('012145678901')).to be_nil
        expect(CogiPhony.mobifone?('8412145678901')).to be_nil
        expect(CogiPhony.mobifone?('+8412145678901')).to be_nil
      end
    end
  end

  describe '#vinaphone?' do
    context 'mobile phone begin with 91' do
      it 'length equal 10 is valid' do
        expect(CogiPhony.vinaphone?('0914567890')).not_to be_nil
        expect(CogiPhony.vinaphone?('84914567890')).not_to be_nil
        expect(CogiPhony.vinaphone?('+84914567890')).not_to be_nil
      end

      it 'length less than 10 is invalid' do
        expect(CogiPhony.vinaphone?('091456789')).to be_nil
        expect(CogiPhony.vinaphone?('8491456789')).to be_nil
        expect(CogiPhony.vinaphone?('+8491456789')).to be_nil
      end

      it 'length more than 10 is invalid' do
        expect(CogiPhony.vinaphone?('09145678901')).to be_nil
        expect(CogiPhony.vinaphone?('849145678901')).to be_nil
        expect(CogiPhony.vinaphone?('+849145678901')).to be_nil
      end
    end

    context 'mobile phone begin with 123' do
      it 'length equal 11 is valid' do
        expect(CogiPhony.vinaphone?('01234567890')).not_to be_nil
        expect(CogiPhony.vinaphone?('841234567890')).not_to be_nil
        expect(CogiPhony.vinaphone?('+841234567890')).not_to be_nil
      end

      it 'length less than 11 is invalid' do
        expect(CogiPhony.vinaphone?('0123456789')).to be_nil
        expect(CogiPhony.vinaphone?('84123456789')).to be_nil
        expect(CogiPhony.vinaphone?('+84123456789')).to be_nil
      end

      it 'length more than 11 is invalid' do
        expect(CogiPhony.vinaphone?('012345678901')).to be_nil
        expect(CogiPhony.vinaphone?('8412345678901')).to be_nil
        expect(CogiPhony.vinaphone?('+8412345678901')).to be_nil
      end
    end
  end

  describe '#viettel?' do
    context 'mobile phone begin with 98' do
      it 'length equal 10 is valid' do
        expect(CogiPhony.viettel?('0984567890')).not_to be_nil
        expect(CogiPhony.viettel?('84984567890')).not_to be_nil
        expect(CogiPhony.viettel?('+84984567890')).not_to be_nil
      end

      it 'length less than 10 is invalid' do
        expect(CogiPhony.viettel?('098456789')).to be_nil
        expect(CogiPhony.viettel?('8498456789')).to be_nil
        expect(CogiPhony.viettel?('+8498456789')).to be_nil
      end

      it 'length more than 10 is invalid' do
        expect(CogiPhony.viettel?('09845678901')).to be_nil
        expect(CogiPhony.viettel?('849845678901')).to be_nil
        expect(CogiPhony.viettel?('+849845678901')).to be_nil
      end
    end

    context 'mobile phone begin with 168' do
      it 'length equal 11 is valid' do
        expect(CogiPhony.viettel?('01684567890')).not_to be_nil
        expect(CogiPhony.viettel?('841684567890')).not_to be_nil
        expect(CogiPhony.viettel?('+841684567890')).not_to be_nil
      end

      it 'length less than 11 is invalid' do
        expect(CogiPhony.viettel?('0168456789')).to be_nil
        expect(CogiPhony.viettel?('84168456789')).to be_nil
        expect(CogiPhony.viettel?('+84168456789')).to be_nil
      end

      it 'length more than 11 is invalid' do
        expect(CogiPhony.viettel?('016845678901')).to be_nil
        expect(CogiPhony.viettel?('8416845678901')).to be_nil
        expect(CogiPhony.viettel?('+8416845678901')).to be_nil
      end
    end
  end

  describe '#phone_to_provider' do
    it 'return Viettel' do
      expect(CogiPhony.phone_to_provider('0988091097')).to eq('Viettel')
      expect(CogiPhony.phone_to_provider('84988091097')).to eq('Viettel')
      expect(CogiPhony.phone_to_provider('+84988091097')).to eq('Viettel')
    end

    it 'return Mobifone' do
      expect(CogiPhony.phone_to_provider('0938091097')).to eq('Mobifone')
      expect(CogiPhony.phone_to_provider('84938091097')).to eq('Mobifone')
      expect(CogiPhony.phone_to_provider('+84938091097')).to eq('Mobifone')
    end

    it 'return Vinaphone' do
      expect(CogiPhony.phone_to_provider('0918091097')).to eq('Vinaphone')
      expect(CogiPhony.phone_to_provider('84918091097')).to eq('Vinaphone')
      expect(CogiPhony.phone_to_provider('+84918091097')).to eq('Vinaphone')
    end

    it 'return Vietnamobile' do
      expect(CogiPhony.phone_to_provider('0928091097')).to eq('Vietnamobile')
      expect(CogiPhony.phone_to_provider('84928091097')).to eq('Vietnamobile')
      expect(CogiPhony.phone_to_provider('+84928091097')).to eq('Vietnamobile')
    end

    it 'return Gmobile (Beeline)' do
      expect(CogiPhony.phone_to_provider('0998091097')).to eq('Gmobile (Beeline)')
      expect(CogiPhony.phone_to_provider('84998091097')).to eq('Gmobile (Beeline)')
      expect(CogiPhony.phone_to_provider('+84998091097')).to eq('Gmobile (Beeline)')
    end

    it 'return Others' do
      expect(CogiPhony.phone_to_provider('0837621351')).to eq('Others')
      expect(CogiPhony.phone_to_provider('0643676907')).to eq('Others')
      expect(CogiPhony.phone_to_provider('+14037089189')).to eq('Others')
    end
  end
end