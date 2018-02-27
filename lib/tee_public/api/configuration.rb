module TeePublic
  module Api
    class Configuration
      attr_accessor :api_key
      attr_accessor :api_endpoint
      attr_accessor :version
      attr_accessor :debug

      def initialize
        @api_endpoint = 'https://api.teepublic.com/'
        @version = 'v1'
        @debug = false
      end
    end
  end
end