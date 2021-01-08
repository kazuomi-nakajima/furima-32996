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
  # has_one :order
  has_one_attached :image

  # 画像が空は保存できない
  validate :image_presence

  # 空の出品を保存できないようにする
  validates_presence_of :name, :description, :price

  # priceが300円 〜 9999999円以外のときは、保存できないようにする
  validates :price, presence: true,
                    numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 }

  # ActivateHashの選択が「--」の時は保存できないようにする
  validates :category_id, :state_id, :burden_id, :prefecture_id, :delivery_period_id, numericality: { other_than: 1 }

  private

  # 処理：画像が空は保存できない
  def image_presence
    if image.attached?
      errors.add(:image, 'にはjpeg・png・jpgのファイルで添付してください') unless image.content_type.in?(%('image/jpeg image/png image/jpg'))
    else
      errors.add(:image, 'ファイルを添付してください')
    end
  end
end
