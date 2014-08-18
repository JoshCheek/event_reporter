require_relative 'test_helper'

# test cases taken from section titled "Test Cases for Base Expectations" in
# http://tutorials.jumpstartlab.com/projects/event_reporter.html

class IntegrationTest < Minitest::Test
  def cli
    @cli ||= EventReporter::CLI.new
  end

  def test_happy_path
    cli.process "load event_attendees.csv"
    assert_equal 0, cli.process("queue count")

    cli.process("find first_name John")
    assert_equal 63, cli.process("queue count") # 62 match exactly, one matches case insensitive

    cli.process("queue clear")
    assert_equal 0, cli.process("queue count")

    %w[load find queue help].each do |command_name|
      assert_includes cli.process("help"), command_name
    end

    assert_includes cli.process("help queue count"), "Counts the number of items in the queue"
    assert_includes cli.process("help queue print"), "Prints each item in the queue"
    refute_includes cli.process("help queue count"), "Prints each item in the queue"
  end

  def test_output
    # filter, and then re-filter the data for "Mary"s
    cli.process 'load'
    assert_equal 0, cli.process('queue count')
    cli.process 'find first_name John'
    cli.process 'find first_name Mary'

    # 17 lines, first looks like the header we expect
    lines_to_print = cli.process('queue print')
    assert_equal 17, lines_to_print.size # header + 16 rows
    assert_equal lines_to_print.first, "LAST NAME\tFIRST NAME\tEMAIL\tZIPCODE\tCITY\tSTATE\tADDRESS\tPHONE"


    # output is not sorted by last name
    alphabetical_last_names = ["Bastias", "Bell", "Browne", "Campbell", "Coomer", "Corrado", "Costantini", "Grant", "Gray", "Jolly", "Joyce", "Rodgers", "Schuster", "Shpino", "Skaggs", "Ther"]
    unsorted_last_names = cli.process('queue print').drop(1).map { |row| row.split("\t").first }
    refute_equal unsorted_last_names, alphabetical_last_names

    # output is sorted by last name
    sorted_last_names = cli.process('queue print by last_name').drop(1).map { |row| row.split("\t").first }
    assert_equal sorted_last_names, alphabetical_last_names
  end

  def test_saving
    # load
    # find city Salt Lake City
    # queue print should display 13 attendees
    # queue save to city_sample.csv
    # Open the CSV and inspect that it has correct headers and the data rows from step 3.
    # find state DC
    # queue print by last_name should print them alphabetically by last name
    # queue save to state_sample.csv
    # Open the CSV and inspect that it has the headers, the data from step 7, but not the data previously found in step 2.
  end

  def test_reading_data
    skip
    # load
    # find state MD
    # queue save to state_sample.csv
    # quit

    # Restart the program and continue…

    # load state_sample.csv
    # find first_name John
    # queue count should return 4
  end

  def test_emptiness
    skip
    # Note that this set intentionally has no call to load:

    # find last_name Johnson
    # queue count should return 0
    # queue print should not print any attendee data
    # queue clear should not return an error
    # queue print by last_name should not print any data
    # queue save to empty.csv should output a file with only headers
    # queue count should return 0
  end
end
