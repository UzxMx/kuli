class SessionsController < Devise::SessionsController
# before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  def new
    authenticate
  end

  # POST /resource/sign_in
  def create
    authenticate
  end

  def fail
    logger.debug("fail")

    redirect_to 'https://open.weixin.qq.com/connect/oauth2/authorize?appid=wx8035a1ddcde237dc&redirect_uri=http%3a%2f%2fwww.senxieyoujia.com%2fusers%2fsign_in&response_type=code&scope=snsapi_userinfo&state=senxie#wechat_redirect'    
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
      # self.resource will be user
      self.resource = warden.authenticate!({scope: resource_name, recall: "#{controller_path}#fail"})

      # after this, user already authenticated
      redirect_to root_path
    end

end
