require 'read_csv'
require 'identify_command'

class CLI
  attr_accessor :queue, :pristine_data

  def initialize
    self.queue         = []
    self.pristine_data = []
  end

  def process(line)
    name, *arguments = line.split
    command = IdentifyCommand.new(name, arguments)
    case
    when command.load?
      self.pristine_data = ReadCsv.call arguments.first
    when command.queue_count?
      queue.count
    when command.queue_clear?
      self.queue = []
    when command.find?
      attribute, value = arguments
      self.queue = pristine_data.select { |row| row[attribute] == value }
    when command.help?
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
