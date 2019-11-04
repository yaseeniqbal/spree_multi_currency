module  Spree
  module ProductDecorator
    def self.prepended(base)
      alias_method :amount=, :price=
    end

  end
end