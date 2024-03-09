class ItemPurchasesController < ApplicationController

  def index
    @buyer_item_purchase = BuyerItemPurchase.new
    @item = Item.find(params[:item_id])
  end

  def create
    @buyer_item_purchase = BuyerItemPurchase.new(buyer_params)
    if @buyer_item_purchase.valid?
       @buyer_item_purchase.save
       redirect_to root_path
    else
       @item = Item.find(params[:item_id])
       render :index, status: :unprocessable_entity
    end
  end

  private
  def buyer_params
    params.require(:buyer_item_purchase).permit(:post_code, :prefecture_id, :town_name, :number, :telephone_number).merge(user_id: current_user.id, item_id: params[:item_id])
  end
end