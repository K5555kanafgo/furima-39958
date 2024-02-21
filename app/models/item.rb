class Item < ApplicationRecord
    has_many           :comments
    belongs_to         :user
    has_one_attached   :image

    extend ActiveHash::Associations::ActiveRecordExtensions
    belongs_to        :category
    belongs_to        :situation
    belongs_to        :load
    belongs_to        :prefecture
    belongs_to        :number_of_day

    validates :title, :explanation, presence: true

    validates :category_id,      numericality: { other_than: 1, message: "can't be blank" }
    validates :situation_id,     numericality: { other_than: 1, message: "can't be blank" }
    validates :load_id,          numericality: { other_than: 1, message: "can't be blank" }
    validates :prefecture_id,    numericality: { other_than: 1, message: "can't be blank" }
    validates :number_of_day_id, numericality: { other_than: 1, message: "can't be blank" }
end