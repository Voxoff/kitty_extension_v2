require 'httparty'

class UpdateExchangeRateHashJob < ApplicationJob
  queue_as :default

  def perform
    currencies = ["GBP", "EUR", "USD", "CAD", "CHF", "DKK", "AUD", "HKD", "JPY", "RUB", "SGD", "ZAR", "MXN"]
    base_url = "https://api.fixer.io/latest?base="

    currencies.each do |currency|
      url = base_url + currency
      response = HTTParty.get(url)
      base = response.parsed_response["base"]
      rates = response.parsed_response["rates"]
      ex = ExchangeRate.new(base: base, rates: rates)
      ex.save
    end
  end
end
