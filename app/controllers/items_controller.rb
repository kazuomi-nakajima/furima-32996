class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  def index
  end

  def edit
  end

  def new
  end

  def show
  end

  private

  def move_to_index
    unless user_sign_in?
      redirect_to action: :index
    end
  end


end
