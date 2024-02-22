class ItemsController < ApplicationController
  before_action :move_to_index, except: [:index, :new]
  before_action :authenticate_user!, only: [:new, :create]

  def index
    @items = Item.all
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.create(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end 
  end

  private
  def move_to_index
    unless user_signed_in?
      redirect_to action: :index
    end
  end

  def item_params
    params.require(:item).permit(:image, :title, :explanation, :category_id, :situation_id, 
      :load_id, :prefecture_id, :number_of_day_id, :price).merge(user_id: current_user.id)
  end 
end