module Cadmin
  class EventService < ApplicationRecord
    belongs_to :event
    belongs_to :service, optional: true
    belongs_to :discount, optional: true

    delegate :name, :price, :hour_price, :stock, :image_url, :description, :short_dscription, to: :service, prefix: 'service'
    delegate :name, :type_discount, :percentage, :amount, to: :discount, prefix: 'discount' 

    def in_stock?
      if StockByDate.find_by(service_id: self.id, date: self.event.date).nil?
        StockByDate.create(
          service_id: self.service_id, 
          date: self.event.date, 
          stock: self.service.stock
        )
      end
      StockByDate.find_by(service_id: self.service_id, date: self.event.date).stock_available?
    end

    def stock_decrement! 
      if StockByDate.find_by(service_id: self.service_id, date: self.event.date).stock_available? 
        sbd = StockByDate.find_by(service_id: self.service_id, date: self.event.date)
        sbd.stock -= 1
        sbd.save!
      end
    end

    def stock_increment! 
      sbd = StockByDate.find_by(service_id: self.service_id, date: self.event.date)
      sbd.stock += 1
      sbd.save!
    end
  end
end
