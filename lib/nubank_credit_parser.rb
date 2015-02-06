require 'active_support/all'

class NubankCreditParser
  def parse(page_html)
    html = Nokogiri.parse(page_html)

    html.css(".charges-list .charge").map do |tx|
      {
        date: parse_date(tx.css(".time").text),
        memo: tx.css(".description").text,
        value: parse_value(tx.css(".amount").text)
      }
    end
  end

  def parse_date(text)
    day, text_month = text.split(" ")

    "2015-#{month_mapping[text_month]}-#{day}"
  end

  def parse_value(text)
    text.gsub(".","").gsub(",",".").to_f * -1
  end

  def month_mapping
    {
      "Jan" => "01",
      "Fev" => "02",
      "Mar" => "03",
      "Abr" => "04",
      "Mai" => "05",
      "Jun" => "06",
      "Jul" => "07",
      "Ago" => "08",
      "Set" => "09",
      "Out" => "10",
      "Nov" => "11",
      "Dez" => "12"
    }
  end
end
