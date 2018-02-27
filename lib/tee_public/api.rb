require 'faraday'
require 'json'

require "tee_public/api/version"
require "tee_public/api/configuration"

module TeePublic
  module Api
    class << self
      attr_accessor :configuration
      attr_accessor :adapter
    end

    def self.configuration
      @configuration ||= Configuration.new
    end

    def self.configure
      yield(configuration)
    end

    def self.adapter
      @adapter ||= Faraday.new(url: configuration.api_endpoint) do |req|
        req.request  :url_encoded
        req.response :logger if configuration.debug
        req.headers['X-API-Key'] = configuration.api_key unless configuration.api_key.nil?
        req.adapter  Faraday.default_adapter
      end
    end

    def self.method_missing(method_name, *arguments, &block)
      endpoint = method_name
      id = arguments.shift
      addl_params = arguments

      JSON.parse(api_call(endpoint, id, addl_params).body)
    end

    private
    def self.api_call(endpoint, id = nil, addl_params = [])
      url = "#{configuration.version}/#{endpoint}"
      url += "/#{id}" unless id.nil?

      adapter.get(url) do |request|
        request.params.merge(addl_params)
      end
    end
  end
end
