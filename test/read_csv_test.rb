require_relative 'test_helper'
require 'fakefs/safe'
require 'fileutils'

class ReadCsvTest < Minitest::Test
  DATA_DIR = File.expand_path('../../data', __FILE__)

  def csv(*args)
    EventReporter::ReadCsv.new(*args)
  end

  def test_it_looks_in_the_data_directory
    assert_equal DATA_DIR, File.dirname(csv.filename)
  end

  def test_it_defaults_to_event_attendees
    assert_equal 'event_attendees.csv', File.basename(csv.filename)
    assert_equal 'event_attendees.csv', File.basename(csv(nil).filename)
  end

  def test_it_can_be_overridden
    assert_equal 'other.csv', File.basename(csv('other.csv').filename)
  end

  def test_it_reads_the_csv_using_downcased_headers
    FakeFS do
      # make the path to the data dir in our fake file system
      # then write a fake csv there
      FileUtils.mkdir_p DATA_DIR
      file_path = File.join DATA_DIR, 'somecsv'
      File.write file_path, "header1,HEADER2\nval1,VAL2\n"

      # it should parse that csv correctly
      rows = EventReporter::ReadCsv.call('somecsv')
      assert_equal 1,      rows.size
      assert_equal "val1", rows[0]['header1']
      assert_equal "VAL2", rows[0]['header2']
    end
  end
end
