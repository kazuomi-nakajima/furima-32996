class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit]
  before_action :move_to_index, except: [:index, :show]

  def index
    @item = Item.all.includes(:user).order('created_at DESC')
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      redirect_to action: :show
    else
      render :edit
    end
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
    @item = Item.find(params[:id])
  end

  private

  def move_to_index
    item = Item.find(params[:id].to_i)
    # sold out時に直接urlを叩いたらindexへ遷移するコードは未記入
    unless user_signed_in? && (current_user.id == item.user_id)
      redirect_to action: :index 
    end
  end

  def item_params
    params.require(:item).permit(:name, :description, :price, :category_id, :state_id, :burden_id, :prefecture_id,
                                 :delivery_period_id, :image).merge(user_id: current_user.id)
  end
end
