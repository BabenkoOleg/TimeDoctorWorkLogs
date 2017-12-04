#!/usr/bin/env ruby

$:.unshift './lib'
$LOAD_PATH << File.dirname(__FILE__)

require 'rubygems'
require 'optparse'
require 'worklogs'

Bundler.require
Dotenv.load

options = {}

OptionParser.new do |parser|
  parser.on('-s', '--startdate=DATE', 'The Start Date - format YYYY-MM-DD') do |v|
    options[:start_date] = v
  end

  parser.on('-e', '--enddate=DATE', 'The End Date - format YYYY-MM-DD') do |v|
    options[:end_date] = v
  end
end.parse!

time_doctor = Worklogs::TimeDoctor.new(ENV['TIMEDOCTOR_ACCESS_TOKEN'], 587525)
worklogs = time_doctor.get_worklogs(options[:start_date], options[:end_date])
