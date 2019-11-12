Spree::Core::ControllerHelpers::Order.class_eval do
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




# let following code here - it doesn't work but it has to be there for puma to read file or error willl occur during deployment to heroku
module Spree
  module Core
    module ControllerHelpers
      module OrderDecorator
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
    end
  end
end


::Spree::Core::ControllerHelpers::Order.prepend(::Spree::Core::ControllerHelpers::OrderDecorator)
