require 'spec_helper'

describe TeePublic::Api do
  before(:each) do
    # Reset configuration
    TeePublic::Api.configuration = nil
  end

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
      expect(TeePublic::Api.configuration.api_endpoint).to eq('https://api.teepublic.com/')
    end

    it 'supports a custom endpoint' do
      TeePublic::Api.configure do |config|
        config.api_endpoint = 'http://localhost'
      end

      expect(TeePublic::Api.configuration.api_endpoint).to eq('http://localhost')
    end

    it 'has a default version' do
      expect(TeePublic::Api.configuration.version).to eq('v1')
    end

    it 'supports a custom endpoint' do
      TeePublic::Api.configure do |config|
        config.version = 'v2'
      end

      expect(TeePublic::Api.configuration.version).to eq('v2')
    end

    it 'routes missing methods to that endpoint' do
      WebMock.disable_net_connect!
      TeePublic::Api.configure do |config|
        config.api_endpoint = 'http://test.api.teepublic.com'
      end

      stub_request(:get, "http://test.api.teepublic.com/v1/designs").
         with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Faraday v0.9.2', 'X-Api-Key'=>'ABCDEFG12345'}).
         to_return(:status => 200, :body => '{"status":"ok"}', :headers => {})

      TeePublic::Api.designs
      expect(a_request(:get, 'http://test.api.teepublic.com/v1/designs')).to have_been_made.once
    end
  end
end
