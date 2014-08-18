require_relative 'test_helper'

class ReadCsvTest < Minitest::Test
  DATA_DIR = File.expand_path('../../data', __FILE__)

  def test_it_looks_in_the_data_directory
    assert_equal DATA_DIR, File.dirname(ReadCsv.new.filename)
  end

  def test_it_defaults_to_event_attendees
    assert_equal 'event_attendees.csv', File.basename(ReadCsv.new.filename)
    assert_equal 'event_attendees.csv', File.basename(ReadCsv.new(nil).filename)
  end

  def test_it_can_be_overridden
    assert_equal 'other.csv', File.basename(ReadCsv.new('other.csv').filename)
  end

  def test_it_reads_the_csv_using_downcased_headers
    skip
  end
end
