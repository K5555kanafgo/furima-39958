class Item < ApplicationRecord
    has_many               :comments
    belongs_to             :user
    has_one                :item_purchase
end