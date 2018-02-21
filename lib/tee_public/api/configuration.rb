module TeePublic
  module Api
    class Configuration
      attr_accessor :api_key
      attr_accessor :api_endpoint

      def initialize
        @api_endpoint = 'https://api.teepublic.com'
      end
    end
  end
end