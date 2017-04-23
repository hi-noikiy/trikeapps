class BigFiveResultsPoster
  attr_reader :response_code, :token

  def initialize(results_hash)
    @results_hash = results_hash
  end

  def post
    res = TrikeAppsApi.post!(params: @results_hash)
    @response_code = res.code.to_i
    @token = res.body if res.code == '201'

    res.code == '201'
  end

  private

  class TrikeAppsApi
    class << self
      def post!(params: {})
        req = Net::HTTP::Post.new(uri)
        req.body = params.to_json
        req['Content-Type'] = 'application/json'
        Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
          http.request(req)
        end
      end

      private

      def uri
        URI(url)
      end

      def url
        'https://recruitbot.trikeapps.com/api/v1/roles/mid-senior-web-developer/big_five_profile_submissions'
      end
    end
  end
end
