module Spree
  class CurrencyController < StoreController
    def set
      @country = params[:currency]
      config = supported_countries.with_indifferent_access[@country]
      currency_code = config.dig('currency_name')
      @currency = supported_currencies.find { |currency| currency.iso_code == currency_code }
      # Make sure that we update the current order, so the currency change is reflected.
      current_order.update_attributes!(currency: @currency.iso_code) if current_order
      session[:currency] = currency_code if Spree::Config[:allow_currency_change]
      respond_to do |format|
        format.json { render json: !@currency.nil? }
        format.html do
          # We want to go back to where we came from!
          redirect_back(fallback_location: root_path)
        end
      end
    end
  end
end
