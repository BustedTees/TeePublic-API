require 'spec_helper'

describe TeePublic::Api do
  let(:status_ok_body) { "{\"status\":\"ok\"}" }

  before(:all) do
    WebMock.disable_net_connect!
  end

  it 'has a version number' do
    expect(TeePublic::Api::VERSION).not_to be nil
  end

  describe '#configure' do
    before(:each) do
      TeePublic::Api.configuration.reset!
    end

    it 'has an api key' do
      TeePublic::Api.configure do |config|
        config.api_key = 'ABCDEFG12345'
      end

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
  end

  describe 'API Calls' do
    before(:each) do
      TeePublic::Api.configuration.reset!
      TeePublic::Api.configure do |config|
        config.api_key = 'ABCDEFG12345'
      end
    end

    it 'routes missing methods to that endpoint' do
      stub_request(:get, "https://api.teepublic.com/v1/status").
         with(:headers => {'X-Api-Key'=>'ABCDEFG12345'}).
         to_return(:status => 200, :body => status_ok_body, :headers => {})

      TeePublic::Api.status
      expect(a_request(:get, 'https://api.teepublic.com/v1/status')).to have_been_made.once
    end

    it 'returns parsed JSON from an API call' do
      stub_request(:get, "https://api.teepublic.com/v1/status").
         with(:headers => {'X-Api-Key'=>'ABCDEFG12345'}).
         to_return(:status => 200, :body => status_ok_body, :headers => {})

      response = TeePublic::Api.status

      expect(response).to be_instance_of(Hash)
      expect(response['body']).to be_instance_of(Hash)
      expect(response['headers']).to be_instance_of(Hash)
      expect(response).to eq({'body' => JSON.parse(status_ok_body), 'headers' => {}})
    end

    it 'allows endpoint function calls ids' do
      stub_request(:get, "https://api.teepublic.com/v1/designs/1234").
         with(:headers => {'X-Api-Key'=>'ABCDEFG12345'}).
         to_return(:status => 200, :body => status_ok_body, :headers => {})

      expect(TeePublic::Api.designs(1234)).to be_instance_of(Hash)
    end

    it 'allows parameters via options hash' do
      stub_request(:get, "https://api.teepublic.com/v1/designs/1234").
         with(:headers => {'X-Api-Key'=>'ABCDEFG12345'}, :query => { my_param: 'dog'}).
         to_return(:status => 200, :body => status_ok_body, :headers => {})

      TeePublic::Api.designs(1234, my_param: 'dog')
      expect(a_request(:get, 'https://api.teepublic.com/v1/designs/1234').
        with(query: { my_param: 'dog'}, :headers => {'X-Api-Key'=>'ABCDEFG12345'})
      ).to have_been_made.once
    end

    it 'allows complex endpoint calls via send' do
      stub_request(:get, "https://api.teepublic.com/v1/designs/1234/t-shirts").
         with(:headers => {'X-Api-Key'=>'ABCDEFG12345'}).
         to_return(:status => 200, :body => status_ok_body, :headers => {})

      expect(TeePublic::Api.send("designs/1234/t-shirts")).to be_instance_of(Hash)
    end
  end
end
