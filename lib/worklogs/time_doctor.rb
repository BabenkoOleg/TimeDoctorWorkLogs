module Worklogs
  class TimeDoctor
    API_URL = 'https://webapi.timedoctor.com/v1.1'.freeze

    attr_accessor :config

    def initialize(config)
      @config = config
    end

    def get_worklogs
      worklogs = {}
      (config.from..config.to).uniq.map do |date|
        worklog = get_worklogs_for_day(date.strftime('%Y-%m-%d'))
        worklogs[worklog[:date]] = worklog[:lengths]
      end
      worklogs
    end

    private

    def get_worklogs_for_day(day)
      uri = URI("#{API_URL}/companies/#{config.company_id}/worklogs")
      params = {
        access_token: config.access_token,
        consolidated: 0,
        start_date: day,
        end_date: day,
        _format: 'json'
      }

      uri.query = URI.encode_www_form(params)
      puts "-- get worklogs for: #{day}"

      response = Net::HTTP.get_response(uri)
      raise "#{response.code}: #{response.message}" if response.code != '200'

      parse_worklog(JSON.parse(response.body))
    end

    def parse_worklog(worklog)
      data = { date: worklog['start_time'][/\d+-\d+-\d+/], lengths: {} }
      return data unless worklog['worklogs']['items'].any?

      names = worklog['worklogs']['items'].map { |w| w['user_name'] }.uniq
      names.each do |name|
        lengths = worklog['worklogs']['items'].select { |w| w['user_name'] == name }
                                              .sum { |w| w['length'].to_i }

        data[:lengths][name.strip] = Time.at(lengths).utc.strftime("%H:%M:%S")
      end

      data
    end
  end
end
