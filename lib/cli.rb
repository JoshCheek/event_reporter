require 'csv'
class ReadCsv
  def self.call(filename)
    filepath = File.expand_path("../../data/#{filename}", __FILE__)
    CSV.readlines(filepath, headers: true, header_converters: :downcase) # glanced through docs to get this http://rdoc.info/stdlib/csv/CSV#HeaderConverters-constant
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
      elsif arguments.first == 'clear'
        self.queue = []
      end
    when 'find'
      attribute, value = arguments
      self.queue = pristine_data.select { |row| row[attribute] == value }
    when 'help'
      help_screen
    end
  end

  def help_screen
    commands_with_descriptions.map { |command, description|
      sprintf "%20s %s", command, description
    }.join("\n")
  end

  def commands_with_descriptions
    { 'load'         => 'Loads a CSV to be searched through',
      'find'         => 'Selects relevant rows from the loaded CSV into the queue',
      'help'         => 'Information about all commands',
      'help command' => 'Information about a command',
      'queue clear'  => 'Clears out the current queue',
      'queue count'  => 'Counts the number of items in the queue',
      'queue print'  => 'Prints each item in the queue',
    }
  end
end
