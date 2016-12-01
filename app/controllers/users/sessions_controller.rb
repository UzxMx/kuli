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
        logger.debug("code: #{params[:code]}")
        logger.debug("state: #{params[:state]}")

        json = get_access_token(params[:code])
        user_info = get_user_info(json[:access_token], json[:openid])

        logger.debug("user_info: #{JSON.generate(user_info)}")
      else
        redirect_to 'https://open.weixin.qq.com/connect/oauth2/authorize?appid=wx8035a1ddcde237dc&redirect_uri=http%3a%2f%2fsenxieyoujia.com%2fusers%2fsign_in&response_type=code&scope=snsapi_userinfo&state=senxie#wechat_redirect'
      end

    end

    def get_access_token(code)
      send_request("https://api.weixin.qq.com/sns/oauth2/access_token?appid=#{Kuli::Application::WECHAT_APP_ID}&secret=#{Kuli::Application::WECHAT_APP_SECRET}&code=#{code}&grant_type=authorization_code")
    end

    def get_user_info(access_token, open_id)
      send_request("https://api.weixin.qq.com/sns/userinfo?access_token=#{access_token}&openid=#{open_id}&lang=zh_CN")
    end

    def send_request(url)
      url = URI.parse(url)
      req = Net::HTTP::Get.new(url.to_s)
      res = Net::HTTP.start(url.host, url.port) { |http|
        http.request(req)
      }
      json = JSON.parse(res.body, symbolize_keys: true)
      json     
    end
end
