class BuyerItemPurchase
  include ActiveModel::Model
  attr_accessor :post_code, :prefecture, :town_name, :number, :telephone_number, :building_name, :user_id, :item_id, :token

  with_options presence: true do
    validates :postal_code, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Enter it as follows (e.g. 123-4567)"}
    validates :prefecture_id, numericality: {other_than: 0, message: "can't be blank"}
    validates :telephone_number,  format: {with: /\A\d{10}\z|\A\d{11}\z/, message: "invalid. Input only number"}
  end

  validates :number,     presence: true
  validates :city,       presence: true
  validates :number,     presence: true
  validates :user_id,    presence: true
  validates :item_id,    presence: true
  validates :token,      presence: true

  def save
    item_purchase = ItemPurchase.create(user_id: user_id, item_id: item_id)
    Buyer.create(post_code: post_code, prefecture: prefecture, town_name: town_name, number: number, telephone_number: telephone_number, building_name: building_name)
  end
    
end