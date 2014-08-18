require_relative 'test_helper'

class IdentifyCommandTest < Minitest::Test
  def assert_command(name, arguments, command_predicate)
    assert_predicate IdentifyCommand.new(name, arguments), command_predicate
  end

  def refute_command(name, arguments, command_predicate)
    refute_predicate IdentifyCommand.new(name, arguments), command_predicate
  end

  def test_it_identifies_load
    assert_command 'load',     ['somefile'], :load_command?
    refute_command 'not-load', ['somefile'], :load_command?
  end

  def test_it_identifies_queue_count
    assert_command 'queue',     ['count'],          :queue_count_command?
    refute_command 'queue',     ['not-count'],      :queue_count_command?
    refute_command 'not-queue', ['count'],          :queue_count_command?
  end

  def test_it_identifies_queue_clear
    skip
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
