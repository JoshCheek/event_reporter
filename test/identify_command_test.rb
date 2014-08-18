require_relative 'test_helper'

class IdentifyCommandTest < Minitest::Test
  def assert_command(name, arguments, command_predicate)
    assert_predicate IdentifyCommand.new(name, arguments), command_predicate
  end

  def refute_command(name, arguments, command_predicate)
    refute_predicate IdentifyCommand.new(name, arguments), command_predicate
  end

  def test_it_identifies_load
    assert_command 'load',     ['somefile'], :load?
    refute_command 'not-load', ['somefile'], :load?
  end

  def test_it_identifies_queue_count
    assert_command 'queue',     ['count'],     :queue_count?
    refute_command 'queue',     ['not-count'], :queue_count?
    refute_command 'not-queue', ['count'],     :queue_count?
  end

  def test_it_identifies_queue_clear
    assert_command 'queue',     ['clear'],     :queue_clear?
    refute_command 'queue',     ['not-clear'], :queue_clear?
    refute_command 'not-queue', ['clear'],     :queue_clear?
  end

  def test_it_identifies_find_commands
    assert_command 'find', [],     :find?
    refute_command 'not-find', [], :find?
  end

  def test_it_identifies_help_commands
    assert_command 'help', [],     :help?
    refute_command 'not-help', [], :help?
  end
end
