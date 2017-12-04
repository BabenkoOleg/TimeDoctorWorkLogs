module Worklogs
  class TimeDoctor
    attr_accessor :access_token, :company_id

    API_URL = 'https://webapi.timedoctor.com/v1.1'.freeze

    def initialize(access_token, company_id)
      @access_token = access_token
      @company_id = company_id
    end

    def get_worklogs(from, to)
      uri = URI("#{API_URL}/companies/#{company_id}/worklogs")
      params = {
        access_token: access_token,
        consolidated: 0,
        start_date: from,
        end_date: to,
        _format: 'json'
      }
      uri.query = URI.encode_www_form(params)
      response = Net::HTTP.get_response(uri)

      response.code == '200' ? JSON.parse(response.body)
                             : raise "#{response.code}: #{response.message}"
    end
  end
end
