$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'teepublic/api'
require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir = "spec/support"
  c.hook_into :webmock
end
