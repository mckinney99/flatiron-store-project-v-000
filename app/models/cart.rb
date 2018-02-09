class Cart < ActiveRecord::Base
  has_many :line_items
  has_many :items, through: :line_items
  belongs_to :user

  def total
    total = 0
    self.items.each do |item|
      quantity = self.line_items.find_by(item_id: item.id).quantity
      total += item.price * quantity
      
    end
    total
  end

  def add_item(item_id)
    if existing_line_item = self.line_items.find_by(item_id: item_id)
      existing_line_item.duplicate_items_in_cart
      existing_line_item
    else
      self.line_items.build(item_id: item_id)
    end
  end

  def cart_checkout
    self.items.each do |item|
      quantity = self.line_items.find_by(item_id: item.id).quantity
      item.inventory -= quantity
      item.save
    end
    self.status = "submitted"
    self.save
  end

end
