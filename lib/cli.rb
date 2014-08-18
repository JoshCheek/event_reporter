require 'csv'
class ReadCsv
  def self.call(filename)
    filepath = File.expand_path("../../data/#{filename}", __FILE__)
    CSV.readlines(filepath)
  end
end

class CLI
  attr_accessor :queue, :pristine_data

  def initialize
    self.queue         = []
    self.pristine_data = []
  end

  def process(line)
    command, *arguments = line.split
    case command
    when 'load'
      self.pristine_data = ReadCsv.call arguments.first
    when 'queue'
      if arguments.first == 'count'
        queue.count
      end
    when 'find'
      attribute, value = arguments
      require "pry"
      binding.pry
      self.queue = pristine_data.select { |row| row[attribute] == value }
    end
  end
end
