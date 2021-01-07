class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  private

  # ストロングパラメーターの編集 password以外を追加
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up,
                                      keys: [:nickname, :email, :first_name, :last_name, :furigana_first_name,
                                             :furigana_last_name, :birth_date])
  end
end
