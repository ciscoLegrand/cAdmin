module Cadmin
  class CartItem < ApplicationRecord
    belongs_to :service
    belongs_to :cart

    delegate :name, :price, :hour_price, :stock, :image_url, :description, :short_dscription, to: :service, prefix: 'service'

    # validates :validate_stock

    def set_cart_data (cart, service_id)
      @cart_ip = cart
      @service_id = service_id
    end

    # TODO: VALIDATION STOCK TO CALCULATE THE QUANTITY OF THE SERVICE IS AVILABLE IN THOSE DAYS
    # def validate_stock
    #   service = Service.find(@service_id)
    #   cart = Cart.find(@cart_ip).cart_items.where(service_id: @service_id)
    #   if service.stock < cart.count
    #     errors.add(:service, "No hay stock suficiente")
    #   end
    # end

  end
end
