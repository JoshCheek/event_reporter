require 'csv'

module EventReporter
  class ReadCsv
    def self.call(basename=nil)
      new(filename).call
    end

    attr_accessor :filename

    def initialize(basename=nil)
      self.filename = File.expand_path("../../../data/#{basename || 'event_attendees.csv'}", __FILE__)
    end

    def call
      CSV.readlines(filepath, headers: true, header_converters: :downcase) # glanced through docs to get this http://rdoc.info/stdlib/csv/CSV#HeaderConverters-constant
    end
  end
end
