class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new]
  # before_action :move_to_index, except: [:index]
  def index
    @item = Item.all.includes(:user).order("created_at DESC")
  end

  def edit
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def destroy
  end

  def show
  end

  private

  # def move_to_index
  #   redirect_to action: :index unless user_signed_in?
  # end

  def item_params
    params.require(:item).permit(:name, :description, :price, :category_id, :state_id, :burden_id, :prefecture_id,
                                 :delivery_period_id, :image).merge(user_id: current_user.id)
  end
end
