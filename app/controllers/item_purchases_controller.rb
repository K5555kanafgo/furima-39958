class ItemPurchasesController < ApplicationController
  def index
    @buyer_item_purchases = BuyerItemPurchase.all
  end

  def create
  end

end