module Spree
  class MultiCurrencyConfiguration < Preferences::Configuration
    preference :allow_currency_change, :boolean, default: false
    preference :show_currency_selector, :boolean, default: false
    preference :supported_currencies, :string, default: 'USD'
  end
end

Spree::MultiCurrencyConfiguration::Config = Spree::MultiCurrencyConfiguration.new
