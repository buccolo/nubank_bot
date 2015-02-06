Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new(app, { js_errors: false, :phantomjs_options => ['--ignore-ssl-errors=yes'] })
end

Capybara.current_driver = :poltergeist
Capybara.javascript_driver = :poltergeist
Capybara.run_server = false
Capybara.app_host = "https://conta.nubank.com.br"
