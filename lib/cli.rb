require 'csv'
class ReadCsv
  def self.call(filename)
    filepath = File.expand_path("../../data/#{filename}", __FILE__)
    CSV.readlines(filepath, headers: true, header_converters: :downcase) # glanced through docs to get this http://rdoc.info/stdlib/csv/CSV#HeaderConverters-constant
  end
end

class IdentifyCommand
  attr_accessor :name, :arguments

  def initialize(name, arguments)
    self.name, self.arguments = name, arguments
  end

  def load?
    name == 'load'
  end

  def queue_count?
    name == 'queue' && arguments.first == 'count'
  end

  def queue_clear?
    name == 'queue' && arguments.first == 'clear'
  end

  def find?
    name == 'find'
  end

  def help?
    name == 'help'
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
    identify_command = IdentifyCommand.new(command, arguments)
    case
    when identify_command.load?
      self.pristine_data = ReadCsv.call arguments.first
    when identify_command.queue_count?
      queue.count
    when identify_command.queue_clear?
      self.queue = []
    when identify_command.find?
      attribute, value = arguments
      self.queue = pristine_data.select { |row| row[attribute] == value }
    when identify_command.help?
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
