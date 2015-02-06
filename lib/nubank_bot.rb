$stdout.sync = true

require 'json'
require 'base64'
require 'zlib'
require 'httparty'
require 'capybara/poltergeist'

require_relative './nubank_web_capybara'
require_relative './nubank_web_scraper'
require_relative './nubank_credit_parser'
require_relative './nubank_web_credentials'

class NubankBot
  def run!
    puts "-----> Starting NubankBot"
    payload = NubankWebScraper.new.scrape
    payload.merge!({
      success: true
    })
  rescue => e
    payload = {
      success: false,
      message: e.message,
      backtrace: e.backtrace
    }

    puts "-----> Fail: #{e.message}"
  ensure
    url = ENV['NUBANK_BOT_URL']

    puts "-----> Notifying: #{url}"
    response = HTTParty.post(url, {
      body: compact_body(JSON.generate(payload))
    })

    puts "-----> Response: #{response.code}"
  end

  def compact_body(payload)
    Base64.encode64(Zlib::Deflate.deflate(payload)).tap do |_|
      puts payload
    end
  end
end
