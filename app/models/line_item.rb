class LineItem < ActiveRecord::Base
  belongs_to :cart
  belongs_to :item

  def duplicate_items_in_cart
    self.quantity += 1
    self.save
  end
end
