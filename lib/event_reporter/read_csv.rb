require 'csv'

module EventReporter
  class ReadCsv
    def self.call(filename=nil)
      new(filename).call
    end

    attr_accessor :filename

    def initialize(filename=nil)
      self.filename = (filename || 'event_attendees.csv')
    end

    def call
      filepath = File.expand_path("../../../data/#{filename}", __FILE__)
      CSV.readlines(filepath, headers: true, header_converters: :downcase) # glanced through docs to get this http://rdoc.info/stdlib/csv/CSV#HeaderConverters-constant
    end
  end
end
