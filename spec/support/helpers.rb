module Helpers
  def nubank_credit_html
    File.read(File.expand_path("../../fixtures/nubank_credit.html", __FILE__))
  end
end

