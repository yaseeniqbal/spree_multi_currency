module Spree::Core::ControllerHelpers::OrderDecorator
  def current_currency
    # ensure session currency is supported
    #
    if session.key?(:currency) && supported_currencies.map(&:iso_code).include?(session[:currency])
      session[:currency]
    else
      Spree::Config[:currency]
    end
  end
end

::Spree::Core::ControllerHelpers::Order.prepend(::Spree::Core::ControllerHelpers::OrderDecorator)
