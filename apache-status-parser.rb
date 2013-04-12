#!/usr/bin/env ruby
require 'rubygems'
require 'pry-debugger'

class ApacheStatusParser
  attr_accessor :keys, :scores, :log_scores

  def initialize
    @buffer = File.open('apachestatus.out','r').read.split("\n").reject(&:empty?)
    @keys = get_keys
    @range = get_scoreboard_index_range
    @score_line = get_score_line
  end

  def get_keys
    keys = { 
      "_" => "Waiting",
      "S" => "Starting",
      "R" => "Reading",
      "W" => "SendingReply",
      "K" => "Keepalive",
      "D" => "DNSLookup",
      "C" => "ClosingConnection",
      "L" => "Logging",
      "G" => "GracefullyFinish",
      "I" => "IdleCleanup",
      "." => "Open"
    }
  end
  def get_scoreboard_index_range
    @range = Array.new
    @range << @buffer.find_index { |e| e.match /currently being processed/ } + 1 
    @range << @buffer.index("Scoreboard Key:") - 1
  end
  def get_score_line
    @buffer[@range[0]..@range[1]].join('')
  end
  def calculate_scores
    @scores = Hash.new
    @keys.each_key do |key|
      @scores[key] = @score_line.count(key)
    end
  end
  def log_scores
    log_string = "#{Time.now.strftime("[%d/%b/%Y:%H:%M:%S %z]")} apachestatus"
    @keys.each do |key, value|
      log_string << " #{value}=#{@scores[key]}"
    end
    log_string
  end
end
parse_data = ApacheStatusParser.new
parse_data.calculate_scores
puts parse_data.log_scores
#File.open('/var/log/metrics/apachestatus.log', 'a') { |f|
#end
