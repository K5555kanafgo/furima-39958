class ItemPurchasesController < ApplicationController

  def index
    @buyer_item_purchase = BuyerItemPurchase.new
    @item = Item.find(params[:item_id])
  end

  def create
    @buyer_item_purchase = BuyerItemPurchase.new(buyer_params)
    @item = Item.find(params[:item_id])
    if @buyer_item_purchase.valid?
       pay_item
       @buyer_item_purchase.save
       return redirect_to root_path
    else
       render :index, status: :unprocessable_entity
    end
  end

  private
  def buyer_params
    params.require(:buyer_item_purchase).permit(:post_code, :prefecture_id, :town_name, :number, :building_name, :telephone_number).merge(user_id: current_user.id, item_id: params[:item_id], token: params[:token])
  end

  def pay_item
    Payjp.api_key = '*************************'
    Payjp::Charge.create(
      amount: @item.price,
      card: buyer_params[:token],
      currency: 'jpy'
    )
  end

end