require_relative 'test_helper'

class IdentifyCommandTest < Minitest::Test
  def test_it_identifies_load
    assert_predicate IdentifyCommand.new('load',     ['somefile']).load_command?
    refute_predicate IdentifyCommand.new('not-load', ['somefile']).load_command?
  end

  def test_it_identifies_queue_count
    skip
    assert cli.queue_count_command?('queue',     ['count'])
    refute cli.queue_count_command?('queue',     ['not-count'])
    refute cli.queue_count_command?('not-queue', ['count'])
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
