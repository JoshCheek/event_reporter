module EventReporter
  class IdentifyCommand
    COMMANDS_WITH_DESCRIPTIONS = {
      'load'           => 'Loads a CSV to be searched through',
      'find'           => 'Selects relevant rows from the loaded CSV into the queue',
      'help'           => 'Information about all commands',
      'help <command>' => 'Information about a command',
      'queue clear'    => 'Clears out the current queue',
      'queue count'    => 'Counts the number of items in the queue',
      'queue print'    => 'Prints each item in the queue',
      'queue print by' => 'Prints each item in the queue, sorted by the provided attribute',
    }

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

    def queue_print?
      name == 'queue' && arguments == ['print']
    end

    def queue_print_by?
      name == 'queue' && arguments.take(2) == ['print', 'by']
    end

    def find?
      name == 'find'
    end

    def help?
      name == 'help' && arguments.empty?
    end

    def help_for_command?
      name == 'help' && COMMANDS_WITH_DESCRIPTIONS.key?(arguments.join(' '))
    end
  end
end
