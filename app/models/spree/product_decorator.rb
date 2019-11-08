module  Spree
  module ProductDecorator
    def self.prepended(base)
    end

    def amount=(value)
    	self.price=value
    end
  end
end

::Spree::Product.prepend(::Spree::ProductDecorator)
