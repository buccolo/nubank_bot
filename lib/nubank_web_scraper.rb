class NubankWebScraper
  include Capybara::DSL

  def initialize
    page.driver.headers = {
      'User-Agent' => "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/36.0.1916.153 Safari/537.36",
      'Accept' => 'text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8',
      'Accept-Encoding' => ''
    }

    visit "/"

    @payload = {}
    @credentials = NubankWebCredentials.from_env
  end

  def login
    puts "-----> Login"

    fill_in "username", with: @credentials.cpf
    fill_in "input_001", with: @credentials.senha

    click_on "entrar"
    page.html
    sleep 10

    @logged_in = true
  end

  def scrape
    login
    puts "-----> Credit"

    visit "/#/bills"
    page.html
    sleep 10

    @payload.merge!(
      account_id => NubankCreditParser.new.parse(page.html)
    )

    @payload
  end

  def account_id
    ENV['GRANAIO_NUBANK_ACCOUNT'] || 'credit'
  end
end
