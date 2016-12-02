require 'devise/strategies/authenticatable'

module Devise
  module Strategies
    class WechatAuthenticatable < Authenticatable
      def valid?
        params[:code].present? and params[:state].present and params[:state] == 'senxie'
      end

      def authenticate!
        begin
          json = get_access_token(params[:code])
          user_info = get_user_info(json[:access_token], json[:openid])

          puts "user_info: #{JSON.generate(user_info)}"
          success!
        rescue Exception => e
          fail
        end
      end

      private
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
  end
end

Warden::Strategies.add(:wechat_authenticatable, Devise::Strategies::WechatAuthenticatable)