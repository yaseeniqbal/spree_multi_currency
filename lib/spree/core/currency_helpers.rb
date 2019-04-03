module Spree
  module CurrencyHelpers
    def self.included(receiver)
      receiver.send :helper_method, :supported_currencies, :supported_countries,:country_from_currency, :from_currency
    end

    def supported_currencies
      Spree::Config[:supported_currencies].split(',').map {|code| ::Money::Currency.find(code.strip)}
    end

    def supported_countries
      {
          uae: {
              display_label: 'UAE (د.إ)',
              country_name: 'UAE',
              currency_name: 'AED',
              key: 'uae'
          },
          aus: {
              display_label: 'Australia ($)',
              country_name: 'Australia',
              currency_name: 'USD',
              key: 'aus'
          }
      }
    end

    def country_from_currency
      supported_countries.with_indifferent_access.select{|k,h| h["currency_name"] == current_currency}.first.first
    end

    def from_currency(key)
      supported_countries.with_indifferent_access.select{|k,h| h["currency_name"] == "AED"}.first[-1][key]
    end
  end
end
