require 'spec_helper'

module TeePublic
  module Api
    describe Configuration do
      describe '#api_key=' do
        it 'can set value' do
          config = Configuration.new
          config.api_key = 'ABCDEFG12345'
          expect(config.api_key).to eq('ABCDEFG12345')
        end
      end

      describe '#api_endpoint=' do
        it 'can set value' do
          config = Configuration.new
          config.api_endpoint = 'sample'
          expect(config.api_endpoint).to eq('sample')
        end
      end
    end
  end
end