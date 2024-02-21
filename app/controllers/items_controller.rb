class ItemsController < ApplicationController
  before_action :move_to_index, except: [:index]
  before_action :authenticate_user!, only: [:new]

  def index
    @items = Item.all
  end

  def new
    @item = Item.new
  end

  private
  def move_to_index
    unless user_signed_in?
      redirect_to action: :index
    end
  end
end