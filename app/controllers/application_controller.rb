class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller? #サインアップ前からemailのみデータ操作を許可している

  private

  def after_sign_in_path_for(resource) #デバイスのメソッド、サインイン後の遷移先の指定
    user_path(resource)
  end

  def after_sign_out_path_for(resource)#サインアウト後の遷移先の指定
    root_path
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email]) #サインアップ時にemailのみのデータ操作を許可する
  end
end
