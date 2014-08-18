class CLI
  def process(line)
    command, *arguments = line.split
    case command
    when 'load'
      self.queue = ReadCsv.call arguments.first
    end
  end
end
