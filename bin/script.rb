#!/usr/bin/env ruby

$:.unshift './lib'
$LOAD_PATH << File.dirname(__FILE__)

require 'rubygems'
require 'optparse'
require 'worklogs'

Bundler.require

config = Worklogs::Config.new(YAML.load_file('./config.yml'))
config.google_sheet.client_secret = './client_secret.json'

OptionParser.new do |parser|
  parser.on('-s', '--startdate=DATE', 'The Start Date [YYYY-MM-DD]') do |v|
    config.timedoctor.from = DateTime.parse(v)
  end
  parser.on('-e', '--enddate=DATE', 'The End Date [YYYY-MM-DD]') do |v|
    config.timedoctor.to = DateTime.parse(v)
  end
end.parse!

time_doctor = Worklogs::TimeDoctor.new(config.timedoctor)
worklogs = time_doctor.get_worklogs

sheet = Worklogs::GoogleSheet.new(config.google_sheet)
sheet.update(worklogs)
