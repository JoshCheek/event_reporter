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

    def self.call(rows)
      [header_line, *rows.map { |row| format_row row }]
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
