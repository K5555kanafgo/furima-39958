class ItemPurchasesController < ApplicationController

  def index
    @buyer_item_purchases = BuyerItemPurchase.new
    @item = Item.find(params[:item_id])
  end

  def create
  end
  
end