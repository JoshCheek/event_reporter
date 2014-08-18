module EventReporter
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
      name == 'help'
    end
  end
end
