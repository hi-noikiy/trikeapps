require_relative "./app/big_five_results_text_serializer"
require_relative "./app/big_five_results_poster"

text = File.read('./result.txt')
results_hash = BigFiveResultsTextSerializer.new(text).hash
poster = BigFiveResultsPoster.new(results_hash)
if poster.post
  puts "Success, token:\n#{poster.token}"
else
  puts "Failed, errors:\n#{poster.errors}"
end
