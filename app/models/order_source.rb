class OrderSource < ApplicationRecord

  # テーブル関係
  belongs_to :order

  # ActivateHash
  belongs_to :prefecture
end
