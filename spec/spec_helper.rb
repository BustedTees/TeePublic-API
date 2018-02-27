$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'tee_public/api'
require 'vcr'
require 'pry'
require 'webmock/rspec'



# VCR.configure do |c|
#   c.cassette_library_dir = "spec/support"
#   c.hook_into :webmock
# end

WebMock.disable_net_connect!(allow_localhost: true)

