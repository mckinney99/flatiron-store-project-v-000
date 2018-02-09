class Item < ActiveRecord::Base
  belongs_to :category
  has_many :line_items

  def change_inventory
    self.inventory -= 1
    self.save
  end

  def self.available_items
    self.where("inventory > 0")
  end
end
