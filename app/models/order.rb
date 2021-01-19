class Order < ApplicationRecord
  # テーブル関係
  belongs_to :user
  belongs_to :item
  has_one :order_source
end
