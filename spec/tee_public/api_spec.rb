require 'spec_helper'

describe TeePublic::Api do
  it 'has a version number' do
    expect(TeePublic::Api::VERSION).not_to be nil
  end

  describe '#configure' do
    before do
      TeePublic::Api.configure do |config|
        config.api_key = 'ABCDEFG12345'
      end
    end

    it 'has an api key' do
      expect(TeePublic::Api.configuration.api_key).to eq('ABCDEFG12345')
    end

    it 'has a default endpoint' do
      expect(TeePublic::Api.configuration.api_endpoint).to eq('https://api.teepublic.com')
    end

    it 'supports a custom endpoint' do
      TeePublic::Api.configure do |config|
        config.api_endpoint = 'http://localhost'
      end

      expect(TeePublic::Api.configuration.api_endpoint).to eq('http://localhost')
    end
  end
end
