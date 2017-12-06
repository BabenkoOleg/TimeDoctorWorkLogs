module Worklogs
  class Config
    attr_accessor :timedoctor, :google_sheet

    def initialize(config_file)
      @timedoctor = OpenStruct.new(
        access_token: config_file['timedoctor']['access_token'],
        company_id: config_file['timedoctor']['company_id'],
        from: Date.today,
        to: Date.today
      )
      @google_sheet = OpenStruct.new(
        spreadsheet_id: config_file['google']['spreadsheet_id'],
        sheet_title: config_file['google']['sheet_title'],
        start_date: config_file['google']['start_date']
      )
    end
  end
end
