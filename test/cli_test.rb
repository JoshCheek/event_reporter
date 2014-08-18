require_relative 'test_helper'

class CliTest
  class CommandsTest < Minitest::Test
    def cli
      @cli ||= CLI.new
    end

    def test_it_identifies_load
      assert cli.load_command?('load',     ['somefile'])
      refute cli.load_command?('not-load', ['somefile'])
    end

    def test_it_identifies_queue_count
      assert cli.queue_count_command?('queue',     ['count'])
      refute cli.queue_count_command?('queue',     ['not-count'])
      refute cli.queue_count_command?('not-queue', ['count'])
    end

    def test_it_identifies_queue_clear
      assert cli.queue_clear_command?('queue',     ['clear'])
      refute cli.queue_clear_command?('queue',     ['not-clear'])
      refute cli.queue_clear_command?('not-queue', ['clear'])
    end

    def test_it_identifies_find_commands
      skip
    end

    def test_it_identifies_help_commands
      skip
    end
  end
end
