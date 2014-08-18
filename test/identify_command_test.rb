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

  def test_it_identifies_queue_print_by
    assert_command 'queue',     ['print',     'by',     'something'],     :queue_print_by?
    assert_command 'queue',     ['print',     'by',     'something-else'],:queue_print_by?
    refute_command 'not-queue', ['print',     'by',     'something'],     :queue_print_by?
    refute_command 'queue',     ['not-print', 'by',     'something'],     :queue_print_by?
    refute_command 'queue',     ['print',     'not-by', 'something'],     :queue_print_by?
  end

  def test_queue_print_and_queue_print_by_are_mutually_exclusive
    refute_command 'queue', ['print', 'by', 'something'], :queue_print?
    refute_command 'queue', ['print'],                    :queue_print_by?
  end

  def test_it_identifies_help_for_a_command
    assert_command 'help',     ['load'], :help_for_command?
    assert_command 'help',     ['help'], :help_for_command?
    refute_command 'not-help', ['load'], :help_for_command?
  end

  def test_it_considers_all_arguments_as_part_of_the_command_name_in_help_for_a_command
    assert_command 'help', ['queue',     'clear'],     :help_for_command?
    refute_command 'help', ['not-queue', 'clear'],     :help_for_command?
    refute_command 'help', ['queue',     'not-clear'], :help_for_command?
  end

  def test_it_is_not_help_for_a_command_if_the_first_argument_is_not_a_command
    assert_command 'help', ['load'],     :help_for_command?
    refute_command 'help', ['not-load'], :help_for_command?
  end

  def test_help_and_help_command_are_mutually_exclusive
    refute_command 'help', ['load'], :help?
    refute_command 'help', [],       :help_for_command?
  end
end
