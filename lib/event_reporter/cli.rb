require 'event_reporter/read_csv'
require 'event_reporter/format_with_tabs'
require 'event_reporter/identify_command'

module EventReporter
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
      when command.queue_print?
        FormatWithTabs.call queue
      when command.queue_print_by?
        FormatWithTabs.call queue.sort_by { |row| row[arguments.last] }
      when command.find?
        attribute, value = arguments
        self.queue = pristine_data.select { |row| row[attribute].downcase == value.downcase }
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
end
