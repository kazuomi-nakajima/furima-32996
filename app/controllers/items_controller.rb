class ItemsController < ApplicationController
  before_action :set_item, only: [:edit, :update, :show, :destroy] # 重複処理をまとめる
  before_action :authenticate_user!, except: [:index, :show] # ログアウト状態のユーザーがアクセスするとログイン画面へ遷移
  before_action :move_to_index, only: [:edit] # url直接記入の不正アクセス防止

  def index
    @items = Item.all.includes(:user).order('created_at DESC')
  end

  def edit
  end

  def update
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
    @item.destroy if current_user.id == @item.user_id
    redirect_to root_path
  end

  def show
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :price, :category_id, :state_id, :burden_id, :prefecture_id,
                                 :delivery_period_id, :image).merge(user_id: current_user.id)
  end

  def move_to_index
    item = Item.find(params[:id].to_i)
    # sold out時に直接urlを叩いたらindexへ遷移するコードは未記入
    redirect_to action: :index unless user_signed_in? && (current_user.id == item.user_id)
  end

  def set_item
    @item = Item.find(params[:id])
  end
end
