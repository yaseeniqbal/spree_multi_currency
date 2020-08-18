module Spree
  module Admin
    class PricesController < ResourceController
      belongs_to 'spree/product', find_by: :slug

      def create
        params.require(:vp).permit!
        params.require(:cp).permit!
        params[:vp].each do |variant_id, prices|
          variant = Spree::Variant.find(variant_id)
          next unless variant
          supported_currencies.each do |currency|
            price = variant.price_in(currency.iso_code)
            price.price = (prices[currency.iso_code].blank? ? nil : prices[currency.iso_code])
            price.save! if price.new_record? && price.price || !price.new_record? && price.changed?
          end
        end
        params[:cp].each do |variant_id, classification_vals|
          variant = Spree::Variant.find(variant_id)
          next unless variant
          supported_currencies.each do |currency|
            classification_vals[currency.iso_code].each do |classification, price_val| 
              class_price = variant.price_in_classification(currency.iso_code,classification)
              class_price.price = (price_val.blank? ? nil : price_val)
              class_price.save! if class_price.new_record? && class_price.price || !class_price.new_record? && class_price.changed?
            end
          end
        end

        flash[:success] = Spree.t('notice_messages.prices_saved')
        redirect_to admin_product_path(parent)
      end
    end
  end
end
