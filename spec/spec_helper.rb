require_relative "../app/big_five_results_text_serializer"
require_relative "../app/big_five_results_poster"
require 'vcr'

VCR.configure do |config|
  config.cassette_library_dir = 'spec/cassettes'
  config.hook_into :webmock
end