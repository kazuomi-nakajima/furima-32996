class OrdersController < ApplicationController

  def index
    @item = Item.find(params[:item_id]) #item_idでitem情報を取得
  end

  def create
  end

  private

  def order_params
      params.require(:order).merge(user_id: current_user.id, item_id: params[:item_id])
  end

end
