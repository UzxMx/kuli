class Users::SessionsController < Devise::SessionsController
# before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  def new
    authenticate
  end

  # POST /resource/sign_in
  def create
    authenticate
  end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end

  private
    def authenticate
      if params[:code].present? and params[:state].present? and params[:state] == 'senxie'
        logger.debug params[:code]
        logger.debug params[:state]

        render json: {status: 1}
      else
        redirect_to 'https://open.weixin.qq.com/connect/oauth2/authorize?appid=wx8035a1ddcde237dc&redirect_uri=http%3a%2f%2fsenxieyoujia.com%2fusers%2fsign_in&response_type=code&scope=snsapi_userinfo&state=senxie#wechat_redirect'
      end

    end
end
