class OrdersController < ApplicationController
  before_action :set_item, only: [:index, :create] # 単体item情報取得
  before_action :authenticate_user!, only: [:index] # ログアウト状態のユーザーがアクセスするとログイン画面へ遷移
  before_action :move_to_index, only: [:index] # url直接記入の不正アクセス防止

  def index
    @order_processing = OrderProcessing.new
  end

  def create
    @order_processing = OrderProcessing.new(order_processing_params)
    if @order_processing.valid?
      pay_item
      @order_processing.save
      redirect_to root_path
    else
      render action: :index
    end
  end

  private

  def order_processing_params
    params.require(:order_processing).permit(:postal_code, :prefecture_id, :municipal, :address, :phone_number, :building_name).merge(
      token: params[:token], user_id: current_user.id, item_id: @item.id
    )
  end

  def set_item
    @item = Item.find(params[:item_id])
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY'] # PAY.JPテスト秘密鍵
    Payjp::Charge.create(   # Payjp決算処理
      amount: @item.price,  # 商品の値段
      card: order_processing_params[:token], # カードトークン
      currency: 'jpy'                 # 通貨の種類（日本円）
    )
  end

  def move_to_index
    redirect_to root_path if user_signed_in? != true || (current_user.id == @item.user_id) || @item.order.present?
  end
end
