class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :item_url, only: [:edit, :update]

  def index
    @items = Item.order('created_at DESC')
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to item_path(@item.id)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @item.destroy if user_signed_in? && current_user.id == @item.user_id
    redirect_to root_path
  end

  private

  def item_params
    params.require(:item).permit(:image, :title, :explanation, :category_id, :situation_id,
                                 :load_id, :prefecture_id, :number_of_day_id, :price).merge(user_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def item_url
    return unless @item.item_purchase.present? && current_user.id == @item.user_id

    redirect_to root_path
  end
end
