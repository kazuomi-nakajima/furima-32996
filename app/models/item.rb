class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  
  # ActivateHash 一覧
  belongs_to :burden
  belongs_to :category
  belongs_to :delivery_period
  belongs_to :prefecture
  belongs_to :state

  # テーブル関係
  belongs_to :user
  #has_one :order

  # 画像が空は保存できない
  has_one_attached :image

  # 空の出品を保存できないようにする
  validates :name,:description,:price

  # priceが300円 〜 9999999円の時は保存できないようにする
  valideted :price, { numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999 } }

  # ActivateHashの選択が「--」の時は保存できないようにする
  validates :category_id, :state_id, :burden_id, :prefecture_id, :delivery_period_id, numericality: { other_than: 1 } 
end
