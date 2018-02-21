require "tee_public/api/version"
require "tee_public/api/configuration"

module TeePublic
  module Api
    class << self
      attr_accessor :configuration
    end

    def self.configuration
      @configuration ||= Configuration.new
    end

    def self.configure
      yield(configuration)
    end
  end
end
