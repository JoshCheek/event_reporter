require 'csv'

module EventReporter
  class ReadCsv
    DATA_DIR = File.expand_path "../../../data/", __FILE__

    def self.call(basename=nil)
      new(basename).call
    end

    attr_accessor :filename

    def initialize(basename=nil)
      basename ||= 'event_attendees.csv'
      self.filename = File.join DATA_DIR, basename
    end

    def call
      CSV.readlines(filename, headers: true, header_converters: :downcase) # glanced through docs to get this http://rdoc.info/stdlib/csv/CSV#HeaderConverters-constant
    end
  end
end
