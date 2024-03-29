class BuyerItemPurchase
  include ActiveModel::Model
  attr_accessor :post_code, :prefecture_id, :town_name, :number, :telephone_number, :building_name, :user_id, :item_id, :token

  with_options presence: true do
    validates :post_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'is invalid. Enter it as follows (e.g. 123-4567)' }
    validates :telephone_number,  format: { with: /\A\d{10}\z|\A\d{11}\z/, message: 'invalid. Input only number' }
    validates :token
    validates :user_id
    validates :item_id
    validates :town_name
    validates :number
  end

  validates :prefecture_id, numericality: { other_than: 0, message: "can't be blank" }

  def save
    item_purchase = ItemPurchase.create(user_id:, item_id:)
    Buyer.create(post_code:, prefecture_id:, town_name:, number:,
                 building_name:, telephone_number:, item_purchase_id: item_purchase.id)
  end
end
