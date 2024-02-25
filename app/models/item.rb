class Item < ApplicationRecord
    has_many           :comments
    belongs_to         :user
    has_one_attached   :image

    extend ActiveHash::Associations::ActiveRecordExtensions
    belongs_to_active_hash    :category
    belongs_to_active_hash    :situation
    belongs_to_active_hash    :load
    belongs_to_active_hash    :prefecture
    belongs_to_active_hash    :number_of_day

    validates :image,       presence: true
    validates :title,       presence: true
    validates :explanation, presence: true

  with_options presence: true do
    validates :category_id,      numericality: { other_than: 0, message: "can't be blank" }
    validates :situation_id,     numericality: { other_than: 0, message: "can't be blank" }
    validates :load_id,          numericality: { other_than: 0, message: "can't be blank" }
    validates :prefecture_id,    numericality: { other_than: 0, message: "can't be blank" }
    validates :number_of_day_id, numericality: { other_than: 0, message: "can't be blank" }
  end

  with_options presence: true do
    validates :price,    numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999, message: "Out of setting range" }
    validates :price,    numericality: { only_integer: true, message: "Half-width number." }
  end
  
end