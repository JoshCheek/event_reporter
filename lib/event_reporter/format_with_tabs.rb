module EventReporter
  class FormatWithTabs
    COLUMN_TO_DATA = [
      ["LAST NAME",  "last_name"],
      ["FIRST NAME", "first_name"],
      ["EMAIL",      "email_address"],
      ["ZIPCODE",    "zipcode"],
      ["CITY",       "city"],
      ["STATE",      "state"],
      ["ADDRESS",    "street"],
      ["PHONE"       "homephone"],
    ]

    def self.call(rows, attribute_to_sort_by=nil)
      ordered_rows = rows.sort_by.with_index do |row, index|
        row[attribute_to_sort_by] || index
      end

      [header_line, *ordered_rows.map { |row| format_row row }]
    end

    private

    def self.header_line
      COLUMN_TO_DATA.map(&:first).join("\t")
    end

    def self.format_row(row)
      COLUMN_TO_DATA.map { |column, attribute_name| row[attribute_name] }.join("\t")
    end
  end
end
