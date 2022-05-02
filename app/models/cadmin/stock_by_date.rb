module Cadmin
  class StockByDate < ApplicationRecord
    belongs_to :service
    # show stock available by date
    def stock_available? 
      self.stock > 0 
    end
    
  end
end
