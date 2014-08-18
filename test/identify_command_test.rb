require_relative 'test_helper'

class IdentifyCommandTest < Minitest::Test
  def assert_command(name, arguments, command_predicate)
    assert_predicate EventReporter::IdentifyCommand.new(name, arguments), command_predicate
  end

  def refute_command(name, arguments, command_predicate)
    refute_predicate EventReporter::IdentifyCommand.new(name, arguments), command_predicate
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

  def test_it_identifies_find
    assert_command 'find', [],     :find?
    refute_command 'not-find', [], :find?
  end

  def test_it_identifies_help
    assert_command 'help', [],     :help?
    refute_command 'not-help', [], :help?
  end

  def test_it_identifies_queue_print
    assert_command 'queue',     ['print'],     :queue_print?
    refute_command 'not-queue', ['print'],     :queue_print?
    refute_command 'queue',     ['not-print'], :queue_print?
  end
end
