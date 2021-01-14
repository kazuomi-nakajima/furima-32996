class Order < ApplicationRecord

  # テーブル関係
  belongs_to :user
  beolngs_to :item
  has_one :ordersource
  
end
