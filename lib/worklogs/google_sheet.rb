module Worklogs
  class GoogleSheet
    attr_accessor :session, :spreadsheet, :sheet, :config

    def initialize(config)
      @config = config
      @session = GoogleDrive::Session.from_service_account_key(config.client_secret)
      @spreadsheet = session.file_by_id(config.spreadsheet_id)
      @sheet = spreadsheet.worksheet_by_title(config.sheet_title)
    end

    def update(rows)
      names = rows.values.map(&:keys).flatten.uniq
      check_names(names)
      rows.each { |row| add_row_to_sheet(row) }
      sheet.save
    end

    private

    def check_names(names)
      sheet.update_cells(1, existing_names.count + 2, [names - existing_names])
      sheet.save
    end

    def add_row_to_sheet(row)
      top_row = DateTime.parse(row.first).mjd - start_date.mjd + 2
      return if top_row < 1
      values = [row.first, existing_names.map { |name| row.last[name] }].flatten
      sheet.update_cells(top_row, 1, [values])
    end

    def start_date
      @start_date ||= DateTime.parse(config.start_date)
    end

    def existing_names
      @existing_names ||= sheet.rows[0][1..-1]
    end
  end
end
