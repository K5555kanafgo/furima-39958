class ItemPurchasesController < ApplicationController
  before_action :authenticate_user!, only: [:index, :create]
  before_action :set_item, only: [:index, :create]
  before_action :buyer_item_purchase_url, only: [:index, :create]

  def index
    gon.public_key = ENV['PAYJP_PUBLIC_KEY']
    @buyer_item_purchase = BuyerItemPurchase.new
  end

  def create
    @buyer_item_purchase = BuyerItemPurchase.new(buyer_params)
    if @buyer_item_purchase.valid?
      pay_item
      @buyer_item_purchase.save
      redirect_to root_path
    else
      gon.public_key = ENV['PAYJP_PUBLIC_KEY']
      render :index, status: :unprocessable_entity
    end
  end

  private

  def buyer_params
    params.require(:buyer_item_purchase).permit(:post_code, :prefecture_id, :town_name, :number, :building_name, :telephone_number).merge(
      user_id: current_user.id, item_id: params[:item_id], token: params[:token]
    )
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @item.price,
      card: buyer_params[:token],
      currency: 'jpy'
    )
  end

  def buyer_item_purchase_url
    return unless @item.user_id == current_user.id || @item.item_purchase.present?

    redirect_to root_path
  end

  def set_item
    @item = Item.find(params[:item_id])
  end
end
