class OrderProcessing
  # Formオブジェクト
  includes ActiveModel::Model
  attr_accessor :postal_code, :prefecture_id, :municipal, :address, :phone_number, :building_name, :token

  with_optiones presence: true do
    validates :postal_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)" }
    validates :prefecture_id, numericality: { other_than: 1 }
    validates :municipal
    validates :address
    validates :phone_number, format: { with: /\A[0-9]{11}\z/}
    validates :token
  end

  def save
    order = Order.create(user_id: user, item_id: item)
    OrderSource.create(postal_code: postal_code, prefecture_id: prefecture_id, municipal: municipal, address: address, phone_number: phone_number, order_id: order.id)
  end
end